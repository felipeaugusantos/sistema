unit untImpressaoDocs;

interface

Procedure pImprimeDocumento(strNumDoc, strEspDoc, strCodEmp: String);

implementation

uses
  SysUtils,
  untReimpressao;

Procedure pImprimeDocumento(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    objImpressao: TReimpressao;
Begin
  objImpressao := TReimpressao.Create(strNumDoc,
                      strEspDoc,
                      0, 0, '',
                      strCodEmp,
                      '', False, '', False, False,
                      False, '', '', False, 0, False, '');

  objImpressao.pReimprimeDocumento(False,     // blnImpNFDireto: Boolean = False;
                                   False,     // blnQtdOri: Boolean = False;
                                   False,     // blnDocCan: Boolean = False;
                                   True,      // blnVerCfg: Boolean = True;
                                   False,     // blnImpPed: Boolean = False;
                                   opcVideo); // TOpcEditorFast = opcPergunta;

  FreeAndNil(objImpressao);
End;

end.

