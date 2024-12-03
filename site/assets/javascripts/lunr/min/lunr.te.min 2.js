!function(e,t){"function"==typeof define&&define.amd?define(t):"object"==typeof exports?module.exports=t():t()(e.lunr)}(this,function(){return function(e){if(void 0===e)throw new Error("Lunr is not present. Please include / require Lunr before this script.");if(void 0===e.stemmerSupport)throw new Error("Lunr stemmer support is not present. Please include / require Lunr stemmer support before this script.");e.te=function(){this.pipeline.reset(),this.pipeline.add(e.te.trimmer,e.te.stopWordFilter,e.te.stemmer),this.searchPipeline&&(this.searchPipeline.reset(),this.searchPipeline.add(e.te.stemmer))},e.te.wordCharacters="ఀ-ఄఅ-ఔక-హా-ౌౕ-ౖౘ-ౚౠ-ౡౢ-ౣ౦-౯౸-౿఼ఽ్ౝ౷౤౥",e.te.trimmer=e.trimmerSupport.generateTrimmer(e.te.wordCharacters),e.Pipeline.registerFunction(e.te.trimmer,"trimmer-te"),e.te.stopWordFilter=e.generateStopWordFilter("అందరూ అందుబాటులో అడగండి అడగడం అడ్డంగా అనుగుణంగా అనుమతించు అనుమతిస్తుంది అయితే ఇప్పటికే ఉన్నారు ఎక్కడైనా ఎప్పుడు ఎవరైనా ఎవరో ఏ ఏదైనా ఏమైనప్పటికి ఒక ఒకరు కనిపిస్తాయి కాదు కూడా గా గురించి చుట్టూ చేయగలిగింది తగిన తర్వాత దాదాపు దూరంగా నిజంగా పై ప్రకారం ప్రక్కన మధ్య మరియు మరొక మళ్ళీ మాత్రమే మెచ్చుకో వద్ద వెంట వేరుగా వ్యతిరేకంగా సంబంధం".split(" ")),e.te.stemmer=function(){return function(e){return"function"==typeof e.update?e.update(function(e){return e}):e}}();var t=e.wordcut;t.init(),e.te.tokenizer=function(r){if(!arguments.length||null==r||void 0==r)return[];if(Array.isArray(r))return r.map(function(t){return isLunr2?new e.Token(t.toLowerCase()):t.toLowerCase()});var i=r.toString().toLowerCase().replace(/^\s+/,"");return t.cut(i).split("|")},e.Pipeline.registerFunction(e.te.stemmer,"stemmer-te"),e.Pipeline.registerFunction(e.te.stopWordFilter,"stopWordFilter-te")}});