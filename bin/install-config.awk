# JSON parsing and upgrade preparation using POSIX awk (no additional runtime).
# Parse before writing any output; scalars retain their original JSON spelling.
function die(message) {
    print "ERROR: " message > "/dev/stderr"
    failed = 1
    exit 1
}
function ws() { while (substr(input, pos, 1) ~ /^[ \t\r\n]$/) pos++ }
function hex(s,    i,n,c) {
    n = 0
    for (i = 1; i <= length(s); i++) {
        c = index("0123456789abcdef", tolower(substr(s,i,1))) - 1
        if (c < 0) die("Invalid JSON unicode escape in " label)
        n = n * 16 + c
    }
    return n
}
function string(    start,c,e) {
    start = pos++
    while (pos <= length(input)) {
        c = substr(input,pos++,1)
        if (c == "\"") return substr(input,start,pos-start)
        if (c ~ /[[:cntrl:]]/) die("Control character in JSON string in " label)
        if (c == "\\") {
            e = substr(input,pos++,1)
            if (e == "u") {
                if (length(substr(input,pos,4)) != 4) die("Incomplete unicode escape in " label)
                hex(substr(input,pos,4)); pos += 4
            } else if (e !~ /^["\\\/bfnrt]$/) die("Invalid JSON escape in " label)
        }
    }
    die("Unterminated JSON string in " label)
}
# Normalize escaped ASCII keys, including schema keys written as \u escapes.
# Preserve non-ASCII key spelling; values are always preserved verbatim.
function keyname(raw,    s,i,c,e,n,out) {
    s = substr(raw,2,length(raw)-2)
    for (i=1; i<=length(s); i++) {
        c=substr(s,i,1)
        if (c == "\\") {
            e=substr(s,++i,1)
            if (e == "u") {
                n=hex(substr(s,i+1,4)); i+=4
                c=(n > 0 && n < 128) ? sprintf("%c",n) : "\\u" substr(s,i-3,4)
            } else if (e == "n") c="\n"
            else if (e == "r") c="\r"
            else if (e == "t") c="\t"
            else if (e == "b") c=sprintf("%c",8)
            else if (e == "f") c=sprintf("%c",12)
            else c=e
        }
        out=out c
    }
    return out
}
function parse(    id,c,k,raw,v,n,t) {
    ws(); c=substr(input,pos,1); id=++serial
    if (++depth > 100) die("JSON nesting exceeds 100 in " label)
    if (c == "{" || c == "[") {
        type[id]=(c == "{") ? "object" : "array"
        pos++; ws()
        if (substr(input,pos,1) == ((c == "{") ? "}" : "]")) { pos++; depth--; return id }
        while (1) {
            if (c == "{") {
                if (substr(input,pos,1) != "\"") die("Expected object key in " label)
                raw=string(); k=keyname(raw)
                if ((id SUBSEP k) in member) die("Duplicate JSON key in " label ": " k)
                ws(); if (substr(input,pos++,1) != ":") die("Expected colon in " label)
            }
            v=parse(); n=++count[id]; child[id,n]=v
            if (c == "{") { keys[id,n]=raw; member[id,k]=v }
            ws(); t=substr(input,pos++,1)
            if (t == ((c == "{") ? "}" : "]")) break
            if (t != ",") die("Expected comma in " label)
            ws()
        }
    } else if (c == "\"") { type[id]="string"; value[id]=string() }
    else {
        t=substr(input,pos)
        if (match(t,/^-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?/)) type[id]="number"
        else if (match(t,/^(true|false|null)/)) type[id]="literal"
        else die("Invalid JSON value in " label)
        value[id]=substr(t,1,RLENGTH); pos+=RLENGTH
    }
    depth--; return id
}
function document(text,name,    id) {
    input=text; label=name; pos=1; depth=0; id=parse(); ws()
    if (pos <= length(input)) die("Trailing JSON data in " label)
    return id
}
function get(id,key) { return member[id,key] }
function set(id,key,v,    i) {
    for (i=1;i<=count[id];i++) if (keyname(keys[id,i]) == key) { child[id,i]=v; member[id,key]=v; return }
    i=++count[id]; keys[id,i]="\"" key "\""; child[id,i]=v; member[id,key]=v
}
function drop(id,key,    i) {
    for (i=1;i<=count[id];i++) if (keyname(keys[id,i]) == key) child[id,i]=0
    delete member[id,key]
}
function emit(id,padding,    i,out,v,sep,nested) {
    if (type[id] != "object" && type[id] != "array") return value[id]
    out=(type[id] == "object") ? "{" : "["
    nested=padding "  "
    for (i=1;i<=count[id];i++) {
        v=child[id,i]; if (!v) continue
        out=out sep "\n" nested ((type[id] == "object") ? keys[id,i] ": " : "") emit(v,nested); sep=","
    }
    if (sep != "") out=out "\n" padding
    return out ((type[id] == "object") ? "}" : "]")
}
function object(id,where) { if (type[id] != "object") die(where " must be a JSON object") }
function nonempty(id,where) { if (type[id] != "string" || value[id] == "\"\"") die(where " must be a nonempty string") }
function inventory(id,where,    i,name) {
    if (type[id] != "array") die(where " must be a managed skill array; restore the previous inventory before retrying")
    for (i=1;i<=count[id];i++) {
        name=value[child[id,i]]
        if (type[child[id,i]] != "string" || name !~ /^"[a-z0-9]+(-[a-z0-9]+)*"$/) die("Unsafe skill name in " where ": " name)
    }
}
function managed(id,where,    skills,list) {
    object(id,where); skills=get(id,"skills"); object(skills,where ".skills")
    list=get(skills,"managed"); inventory(list,where ".skills.managed"); return list
}
function names(id,destination,    i,name) {
    for (i=1;i<=count[id];i++) {
        name=value[child[id,i]]; name=substr(name,2,length(name)-2)
        if (destination == "cleanup") cleanup[name]=1
        else print name > destination
    }
}
{ documents[FILENAME] = documents[FILENAME] $0 "\n" }
END {
    if (failed) exit 1
    fresh=document(documents[ARGV[1]],ARGV[1])
    fresh_list=managed(fresh,"source config")
    if (type[get(fresh,"version")] != "number" || value[get(fresh,"version")] != "2") die("Source config must use schema version 2")
    nonempty(get(fresh,"shapeVersion"),"source config.shapeVersion")
    retired=document(documents[ARGV[4]],ARGV[4]); inventory(retired,"retired skills")
    if (has_old) {
        old=document(documents[ARGV[2]],ARGV[2]); old_list=managed(old,"installed config")
        object(get(old,"artifacts"),"installed config.artifacts")
        nonempty(get(old,"featuresRoot"),"installed config.featuresRoot")
        old_version=get(old,"version")
        if (type[old_version] != "number" || value[old_version] !~ /^[12]$/) die("Unsupported installed config version")
        result=old
    } else result=fresh
    if (has_manifest) {
        manifest=document(documents[ARGV[3]],ARGV[3]); manifest_list=managed(manifest,"agent installation inventory")
    }
    artifacts=get(result,"artifacts"); object(artifacts,"config.artifacts")
    aliases["prd"]="productSpecification"; aliases["technicalConcept"]="technicalSpecification"
    for (alias in aliases) {
        modern=aliases[alias]; legacy=get(artifacts,alias); current=get(artifacts,modern)
        if (legacy && current && value[legacy] != value[current]) die("Conflicting artifact keys: " alias " and " modern)
        if (legacy && !current) set(artifacts,modern,legacy)
        drop(artifacts,alias)
    }
    required[1]="productSpecification"; required[2]="technicalSpecification"; required[3]="implementationPlan"
    for (i=1;i<=3;i++) nonempty(get(artifacts,required[i]),"config.artifacts." required[i])
    nonempty(get(result,"featuresRoot"),"config.featuresRoot")
    set(result,"version",get(fresh,"version"))
    set(result,"shapeVersion",get(fresh,"shapeVersion"))
    set(get(result,"skills"),"managed",fresh_list)
    # Everything above must succeed before preparation outputs are written.
    print emit(result) > merged_file
    installed=++serial; type[installed]="object"
    installed_skills=++serial; type[installed_skills]="object"
    set(installed,"shapeVersion",get(fresh,"shapeVersion"))
    set(installed,"skills",installed_skills)
    set(installed_skills,"managed",fresh_list)
    print emit(installed) > manifest_file
    names(fresh_list,install_file)
    names(old_list,"cleanup"); names(manifest_list,"cleanup"); names(retired,"cleanup")
    printf "%s", "" > cleanup_file
    for (name in cleanup) print name > cleanup_file
}
