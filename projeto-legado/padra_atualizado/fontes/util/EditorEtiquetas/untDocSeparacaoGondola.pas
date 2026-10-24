unit untDocSeparacaoGondola;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient;

Type

  TLeDocumentoSeparacaoGondola = Class(TLeDocumento)
  private
    //cdsMovPro,
    //cdsMovDet: TZClient;

    function fGetSQLSep: String;
    function fGetSQLSepDet: String;
    Function fInsereClientSep: Boolean;
    Function fInsereClientDet: Boolean;
  Public

    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;
  Protected
  end;

implementation

uses untConstantes, Data.DB, Math, untTypesSistema;


{ TLeDocumentoSeparacaoGondola }

constructor TLeDocumentoSeparacaoGondola.Create(Owner: TComponent);
begin
  inherited;
end;

destructor TLeDocumentoSeparacaoGondola.Destroy;
begin

  inherited;
end;

function TLeDocumentoSeparacaoGondola.fGetSQLSep: String;
begin
  Result := '';
  Result := Result +'SELECT SOL_CODEMP AS CODEMP ';
  Result := Result +'  FROM SOLGON';
  Result := Result +'  INNER JOIN CADITE C ON C.ITE_CODITE = SOL_CODITE ';
  Result := Result +'  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = SOL_CODOPE';
  Result := Result +'  LEFT JOIN CADOPE OB ON OB.OPE_CODOPE = SOL_OPEBAI';

  Result := Result +'';
  Result := Result +' WHERE SOL_CODEMP = "'+VS_strCodEmp+'"';
  If Not recDocume.SeparacaoGondolaFiltro.blnFiltraApenasListaSolGon Then
  Begin

    If not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strOperadorSolicitacao) Then
      Result := Result +' AND OS.OPE_CODOPE = "'+recDocume.SeparacaoGondolaFiltro.strOperadorSolicitacao+'"';
    If not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strOperadorEfetivacao) Then
      Result := Result +' AND OB.OPE_CODOPE = "'+recDocume.SeparacaoGondolaFiltro.strOperadorEfetivacao+'"';
    Case recDocume.SeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro of
      tsgiImpresso: Result := Result +' AND SOL_IMPREA = "S"';
      tsgiffNaoImpresso: Result := Result +' AND SOL_IMPREA = "N"';
    End;
      Result := Result +' AND SOL_STATUS = 2';

    If recDocume.SeparacaoGondolaFiltro.dtaDataEfetivacao > 0 Then
      Result := Result +' AND DATE(SOL_DTABAI) = :DTABAI'
    Else
      Result := Result +' AND SOL_DTABAI IS NOT NULL';
  End;
  If Not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strListaSolGon) Then
    Result := Result +' AND SOLGON.AUTOINCREM IN ('+recDocume.SeparacaoGondolaFiltro.strListaSolGon+')';

end;

function TLeDocumentoSeparacaoGondola.fGetSQLSepDet: String;
begin
  Result := '';
  Result := Result +'SELECT SOL_CODEMP AS CODEMP,';
  Result := Result +'       SOL_CODOPE AS SOLOPE,';
  Result := Result +'       OS.OPE_NOMOPE AS NOMPSO,';
  Result := Result +'       SOL_CODITE AS CODITE,';
  Result := Result +'       C.ITE_DESITE AS DESITE,';
  Result := Result +'       C.ITE_CODFAB AS CODFAB,';
  Result := Result +'       SOL_NUMLOT AS NUMLOT,';
  Result := Result +'       SOL_QTDITE AS QTDSOL,';
  Result := Result +'       SOL_OBSERV AS OBSSOL,';
  Result := Result +'       CASE WHEN SOL_STATUS = 0 THEN "Indefinido"';
  Result := Result +'            WHEN SOL_STATUS = 1 THEN "Negado"';
  Result := Result +'            WHEN SOL_STATUS = 2 THEN "Autorizado"';
  Result := Result +'       END AS SOLSTA,';
  Result := Result +'       SOL_QTDATD AS QTDATD,';
  Result := Result +'       SOL_LOTORI AS LOTORI,';
  Result := Result +'       SOL_LOCFIS AS SOLFIS,';
  Result := Result +'       SOL_OBSTRA AS OBSLIB,';
  Result := Result +'       SOL_FISORI AS FISORI,';
  Result := Result +'       SOL_DTASOL AS DTASOL,';
  Result := Result +'       SOL_DTABAI AS DTABAI,';
  Result := Result +'       SOL_OPEBAI AS OPEBAI,';
  Result := Result +'       OS.OPE_NOMOPE AS NOMOPB,';
  Result := Result +'       SOL_IMPREA AS IMPREA';
  Result := Result +'  FROM SOLGON';
  Result := Result +'  INNER JOIN CADITE C ON C.ITE_CODITE = SOL_CODITE ';
  Result := Result +'  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = SOL_CODOPE';
  Result := Result +'  LEFT JOIN CADOPE OB ON OB.OPE_CODOPE = SOL_OPEBAI';

  Result := Result +'';
  Result := Result +' WHERE SOL_CODEMP = "'+VS_strCodEmp+'"';
  If Not recDocume.SeparacaoGondolaFiltro.blnFiltraApenasListaSolGon Then
  Begin
    If not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strOperadorSolicitacao) Then
      Result := Result +' AND OS.OPE_CODOPE = "'+recDocume.SeparacaoGondolaFiltro.strOperadorSolicitacao+'"';
    If not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strOperadorEfetivacao) Then
      Result := Result +' AND OB.OPE_CODOPE = "'+recDocume.SeparacaoGondolaFiltro.strOperadorEfetivacao+'"';
    Case recDocume.SeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro of
      tsgiImpresso: Result := Result +' AND SOL_IMPREA = "S"';
      tsgiffNaoImpresso: Result := Result +' AND SOL_IMPREA = "N"';
    End;

    If recDocume.SeparacaoGondolaFiltro.dtaDataEfetivacao > 0 Then
      Result := Result +' AND DATE(SOL_DTABAI) = :DTABAI'
    Else
      Result := Result +' AND SOL_DTABAI IS NOT NULL';
  End;
  If Not fEmptyStr(recDocume.SeparacaoGondolaFiltro.strListaSolGon) Then
    Result := Result +' AND SOLGON.AUTOINCREM IN ('+recDocume.SeparacaoGondolaFiltro.strListaSolGon+')';
end;

function TLeDocumentoSeparacaoGondola.fInsereClientDet: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLSepDet);

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If SeparacaoGondolaFiltro.dtaDataEfetivacao > 0 Then
       ParamByName('DTABAI').AsDate := SeparacaoGondolaFiltro.dtaDataEfetivacao;
    Result := fAbreClient(True, 'fInsereClientDet');
  End;

end;

function TLeDocumentoSeparacaoGondola.fInsereClientSep: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLSep);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If SeparacaoGondolaFiltro.dtaDataEfetivacao > 0 Then
       ParamByName('DTABAI').AsDate := SeparacaoGondolaFiltro.dtaDataEfetivacao;
    Result := fAbreClient(True, 'fInsereClientPro');
  End;
end;

function TLeDocumentoSeparacaoGondola.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  If recDocume.strCodEmp = '' Then
    recDocume.strCodEmp := VS_strCodEmp;
  Result := True;
  Try
    Result := Result And fInsereClientDet;

    Result := Result And fInsereClientSep;


    Result := Result And fInsereClientEmpresa;

    {Result := Result And fInsereClientEnderecoEntrega(cdsMovPro.FieldByName('ENTGER').AsString,
                                                      cdsMovPro.FieldByName('TABELA').AsString,
                                                      ''); }

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

end.
