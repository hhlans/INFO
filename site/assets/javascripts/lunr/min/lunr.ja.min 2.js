!function(e,r){"function"==typeof define&&define.amd?define(r):"object"==typeof exports?module.exports=r():r()(e.lunr)}(this,function(){return function(e){if(void 0===e)throw new Error("Lunr is not present. Please include / require Lunr before this script.");if(void 0===e.stemmerSupport)throw new Error("Lunr stemmer support is not present. Please include / require Lunr stemmer support before this script.");var r="2"==e.version[0];e.ja=function(){this.pipeline.reset(),this.pipeline.add(e.ja.trimmer,e.ja.stopWordFilter,e.ja.stemmer),r?this.tokenizer=e.ja.tokenizer:(e.tokenizer&&(e.tokenizer=e.ja.tokenizer),this.tokenizerFn&&(this.tokenizerFn=e.ja.tokenizer))};var t=new e.TinySegmenter;e.ja.tokenizer=function(i){var n,o,s,p,a,u,m,l,c,f;if(!arguments.length||null==i||void 0==i)return[];if(Array.isArray(i))return i.map(function(t){return r?new e.Token(t.toLowerCase()):t.toLowerCase()});for(o=i.toString().toLowerCase().replace(/^\s+/,""),n=o.length-1;n>=0;n--)if(/\S/.test(o.charAt(n))){o=o.substring(0,n+1);break}for(a=[],s=o.length,c=0,l=0;c<=s;c++)if(u=o.charAt(c),m=c-l,u.match(/\s/)||c==s){if(m>0)for(p=t.segment(o.slice(l,c)).filter(function(e){return!!e}),f=l,n=0;n<p.length;n++)r?a.push(new e.Token(p[n],{position:[f,p[n].length],index:a.length})):a.push(p[n]),f+=p[n].length;l=c+1}return a},e.ja.stemmer=function(){return function(e){return e}}(),e.Pipeline.registerFunction(e.ja.stemmer,"stemmer-ja"),e.ja.wordCharacters="一二三四五六七八九十百千万億兆一-龠々〆ヵヶぁ-んァ-ヴーｱ-ﾝﾞa-zA-Zａ-ｚＡ-Ｚ0-9０-９",e.ja.trimmer=e.trimmerSupport.generateTrimmer(e.ja.wordCharacters),e.Pipeline.registerFunction(e.ja.trimmer,"trimmer-ja"),e.ja.stopWordFilter=e.generateStopWordFilter("これ それ あれ この その あの ここ そこ あそこ こちら どこ だれ なに なん 何 私 貴方 貴方方 我々 私達 あの人 あのかた 彼女 彼 です あります おります います は が の に を で え から まで より も どの と し それで しかし".split(" ")),e.Pipeline.registerFunction(e.ja.stopWordFilter,"stopWordFilter-ja"),e.jp=e.ja,e.Pipeline.registerFunction(e.jp.stemmer,"stemmer-jp"),e.Pipeline.registerFunction(e.jp.trimmer,"trimmer-jp"),e.Pipeline.registerFunction(e.jp.stopWordFilter,"stopWordFilter-jp")}});