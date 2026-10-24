unit untIMesesGiro;

interface

Uses
  DB, UniClientDataSet;

Type
  IMesesGiro = interface
      Function fValidaMeses(intNroMes: Integer): Boolean;
      Function fRetMeses: String;
      Function fPodeMarcar: Boolean;
      Function fRetMesesNormais(intNroMes: Integer; dtaDtaBas: TDateTime): String;
      Function fSelecionouMesAtual: Boolean;
      Function fRetMes(intMes: Integer): Integer;
      Function fRetAno(intMes: Integer): Integer;
      Function fStrMes(intMes: Integer): String;
      Function fStrAno(intMes: Integer): String;
      Function fGetDataSource: TDataSource;
      function fRetQuantidadeDias(blnConsiderarMesAtual: Boolean): Integer;
      Function fGetClient: TUniClientDataSet;
      Function fGetTestaLimite: Boolean;
      Procedure pSetTestaLimite(Value: Boolean);

      procedure pDesmarcaTodos;
      Procedure pMarcaMeses(strMeses: String);
      Procedure pMontaDatas;
      Procedure pPost;
      Procedure pMarcaMesesIniciais;

      Function fGetQtdMes: Integer;
      Procedure pSetQtdMes(Value: Integer);
      Function fGetMarcados: Integer;

      Property intQtdMes: Integer Read fGetQtdMes Write pSetQtdMes;
      Property cdsClient: TUniClientDataSet Read fGetClient;
      Property blnTestaLimite: Boolean Read fGetTestaLimite Write pSetTestaLimite;
      Property intMarcados: Integer Read fGetMarcados;
  End;

implementation

end.
