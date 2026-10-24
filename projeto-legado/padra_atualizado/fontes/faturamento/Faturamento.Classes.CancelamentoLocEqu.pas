unit Faturamento.Classes.CancelamentoLocEqu;

interface

uses
  Classes, SysUtils, faturamento.Classes.FaturamentoLocEqu,
  cadastro.Model.ContratoLocacaoEquipamentos, System.Generics.Collections, Uni,
  cadastro.Controller.ContratoLocacaoEquipamentos;

type

  TCancelarContratoLocacao = Class
  private
    FObjContrato: TContratoLocacaoEquipamentos;
    FListaFaturas: TList<TFaturamentoContrato>;
    FFatura: TFaturamentoContrato;
    FobjValidaCtr: TValidarContrato;

    procedure pLimparDadosEncerramentoDocumento(strCodEmp, strEspSel,strNumDoc, strCodCli: string);

    function GetLstFat: TList<TFaturamentoContrato>;
    procedure SetLstFat(const AValue: TList<TFaturamentoContrato>);
    function GetContrato: TContratoLocacaoEquipamentos;
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    function GetFatura: TFaturamentoContrato;
    procedure SetFatura(const AValue: TFaturamentoContrato);
  public
    constructor Create(blnCriaTmp: Boolean = True);
    destructor Destroy;override;

    function fCarregarFaturasCancelar(const objContrato: TContratoLocacaoEquipamentos): Boolean;
    function fAddFatura: TFaturamentoContrato;
    function fDesvinculaContratoLocacaoRL(strNumDup, strEspDoc, strCodCli, strCodEmp: String; fltValDup: Double): Boolean;
    function fDesvincularDocumentoContrato(strAutIncCon, strCodEmp, strEspSel, strNumDoc, strCodCli, strAutIncAdt: String): Boolean;
    procedure pAtualizarPedidoAdiantamento(const strAutIncAdt: String;
      strEspDoc, strEmpDoc, strNumDoc: String; blnAtualizarPedido: Boolean = False);
    function fLimparDadosContrato(strEspSel, strNumDoc, strCodCli: String): Boolean;

    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property ListaFaturas: TList<TFaturamentoContrato> read GetLstFat write SetLstFat;
    property FaturaCanc: TFaturamentoContrato read GetFatura write SetFatura;
  End;

implementation

uses
  untFuncoesSimples, untCancelamentoDocumentos;


{ TCancelarContratoLocacao }

constructor TCancelarContratoLocacao.Create(blnCriaTmp: Boolean = True);
begin
  FObjContrato := TContratoLocacaoEquipamentos.Create;
  FListaFaturas := TList<TFaturamentoContrato>.Create;
  FFatura := TFaturamentoContrato.Create(FObjContrato, blnCriaTmp);
  FobjValidaCtr := TValidarContrato.Create(FObjContrato);
end;

destructor TCancelarContratoLocacao.Destroy;
begin
  inherited;

  If Assigned(FobjValidaCtr)Then
    FreeAndNil(FobjValidaCtr);
  If Assigned(FFatura) Then
    FreeAndNil(FFatura);
  If Assigned(FListaFaturas) Then
    FreeAndNil(FListaFaturas);
end;

function TCancelarContratoLocacao.fAddFatura: TFaturamentoContrato;
var
  aFatTemp: TFaturamentoContrato;
begin
  aFatTemp := TFaturamentoContrato.Create(FObjContrato);
  FListaFaturas.Add(aFatTemp);
  Result := aFatTemp;
end;

function TCancelarContratoLocacao.fCarregarFaturasCancelar(
  const objContrato: TContratoLocacaoEquipamentos): Boolean;
var
  qryConsulta: TUniQuery;
  itemFatura: TFaturamentoContrato;
begin
  FObjContrato := objContrato;
  FFatura.Contrato := FObjContrato;
  FListaFaturas.Clear;

  qryConsulta := fCriaQuery;
  Try
    Try
      qryConsulta.DisableControls;
      qryConsulta.SQL.Add('SELECT SUM(EQF_VALFAT) AS EQF_VALFAT, ');
      qryConsulta.SQL.Add('       EQF_EMPDOC,                ');
      qryConsulta.SQL.Add('       EQF_ESPDOC,                ');
      qryConsulta.SQL.Add('       EQF_NUMDOC,                ');
      qryConsulta.SQL.Add('       EQF_SERDOC,                ');
      qryConsulta.SQL.Add('       EQF_DTAFAT,                ');
      qryConsulta.SQL.Add('       EQF_HRAFAT                 ');
      qryConsulta.SQL.Add(' FROM EQLFAT                      ');
      qryConsulta.SQL.Add('   WHERE EQF_SEQCON = :SEQCON     ');
      qryConsulta.SQL.Add(' GROUP BY EQF_EMPDOC, EQF_ESPDOC, EQF_NUMDOC, EQF_SERDOC, EQF_DTAFAT');
      qryConsulta.SQL.Add(' ORDER BY EQF_EMPDOC, EQF_ESPDOC, EQF_NUMDOC, EQF_SERDOC, EQF_DTAFAT');
      qryConsulta.ParamByName('SEQCON').AsString := FObjContrato.AutInc;
      qryConsulta.Open;
      If Not qryConsulta.IsEmpty Then
      Begin
        While Not qryConsulta.EOF Do
        Begin
          itemFatura := fAddFatura;
          itemFatura.NumDoc := qryConsulta.FieldByName('EQF_NUMDOC').AsString;
          itemFatura.EspDoc := qryConsulta.FieldByName('EQF_ESPDOC').AsString;
          itemFatura.EmpDoc := qryConsulta.FieldByName('EQF_EMPDOC').AsString;
          itemFatura.SerDoc := qryConsulta.FieldByName('EQF_SERDOC').AsString;
          itemFatura.DataFaturamento := qryConsulta.FieldByName('EQF_DTAFAT').AsDateTime;
          itemFatura.HoraFaturamento := qryConsulta.FieldByName('EQF_HRAFAT').AsDateTime;
          itemFatura.ValorTotal := qryConsulta.FieldByName('EQF_VALFAT').AsFloat;

          qryConsulta.Next;
        End;
      End;

      Result := qryConsulta.RecordCount > 0;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TCancelarContratoLocacao.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FObjContrato;
end;

function TCancelarContratoLocacao.GetFatura: TFaturamentoContrato;
begin
  Result := FFatura;
end;

function TCancelarContratoLocacao.GetLstFat: TList<TFaturamentoContrato>;
begin
  Result := FListaFaturas;
end;

procedure TCancelarContratoLocacao.pAtualizarPedidoAdiantamento(const strAutIncAdt: String;
  strEspDoc, strEmpDoc, strNumDoc: String; blnAtualizarPedido: Boolean = False);
var
  objPedidoAdiantamento:  TPedidoContratoLocacao;
  intCont: Integer;
  strSeqEql: String;
begin
  objPedidoAdiantamento := TPedidoContratoLocacao.Create(FObjContrato);
  Try
    FFatura.pCarregarDetalhamentoFaturamento(strEspDoc,
                                             strEmpDoc,
                                             strNumDoc);

    For intCont := 0 to FFatura.ListaItens.Count-1 Do
    Begin
      strSeqEql := FFatura.ListaItens[intCont].itemContrato.Equipamento.AutInc;
      objPedidoAdiantamento.fDesmarcaPedidoFaturado(strAutIncAdt, strSeqEql);
    End;

    If blnAtualizarPedido Then
      objPedidoAdiantamento.fAtualizarPedido;
  Finally
    FreeAndNil(objPedidoAdiantamento);
  End;
end;

procedure TCancelarContratoLocacao.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FObjContrato := AValue;
end;

procedure TCancelarContratoLocacao.SetFatura(const AValue: TFaturamentoContrato);
begin
  FFatura := AValue;
end;

procedure TCancelarContratoLocacao.SetLstFat(
  const AValue: TList<TFaturamentoContrato>);
begin
  FListaFaturas := AValue;
end;

function TCancelarContratoLocacao.fDesvincularDocumentoContrato(strAutIncCon, strCodEmp, strEspSel,
  strNumDoc, strCodCli, strAutIncAdt: String): Boolean;
Var
  blnAtualizarPD_ItensEnc: Boolean;
begin
  Try
    blnAtualizarPD_ItensEnc := False;
    FObjContrato.fCarregarContrato(strAutIncCon);
    If FobjValidaCtr.fContratoPossuiProrrogacao(strAutIncCon) Then
    Begin
      FObjContrato.pCalculaDuracaoContrato;
      pLimparDadosEncerramentoDocumento(strCodEmp, strEspSel, strNumDoc, strCodCli);
      FObjContrato.pCalculaTotais;
      FObjContrato.pAtualizarItensContrato;
      FObjContrato.pAtualizaTotalContrato;
      blnAtualizarPD_ItensEnc := True;
    End;
    pAtualizarPedidoAdiantamento(strAutIncAdt, strEspSel, strCodEmp, strNumDoc, blnAtualizarPD_ItensEnc);
    Result := fLimparDadosContrato(strEspSel,strNumDoc, strCodCli);
  Except
    raise;
  End;
end;

function TCancelarContratoLocacao.fLimparDadosContrato(strEspSel, strNumDoc, strCodCli: String): Boolean;
var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery();
  Try
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE                         ');
      qryAux.SQL.Add('  EQLDET                       ');
      qryAux.SQL.Add('INNER JOIN CONEQL C            ');
      qryAux.SQL.Add('  ON C.AUTOINCREM = EQD_SEQCON ');
      qryAux.SQL.Add('SET                            ');
      qryAux.SQL.Add('  EQD_NUMENV = NULL,           ');
      qryAux.SQL.Add('  EQD_ESPENV = NULL,           ');
      qryAux.SQL.Add('  EQD_EMPENV = NULL,           ');
      qryAux.SQL.Add('  EQD_SERENV = NULL            ');
      qryAux.SQL.Add('WHERE EQD_NUMENV = :NUMDOC     ');
      qryAux.SQL.Add('  AND EQD_ESPENV = :ESPDOC     ');
      qryAux.SQL.Add('  AND EQD_EMPENV = :EMPDOC     ');
      qryAux.SQL.Add('  AND EQL_CODCLI = :CODCLI     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE                         ');
      qryAux.SQL.Add('  EQLDET                       ');
      qryAux.SQL.Add('INNER JOIN CONEQL C            ');
      qryAux.SQL.Add('  ON C.AUTOINCREM = EQD_SEQCON ');
      qryAux.SQL.Add('SET                            ');
      qryAux.SQL.Add('  EQD_NUMRET = NULL,           ');
      qryAux.SQL.Add('  EQD_ESPRET = NULL,           ');
      qryAux.SQL.Add('  EQD_EMPRET = NULL,           ');
      qryAux.SQL.Add('  EQD_SERRET = NULL,           ');
      qryAux.SQL.Add('  EQD_DTAENC = NULL            ');
      qryAux.SQL.Add('WHERE EQD_NUMRET = :NUMDOC     ');
      qryAux.SQL.Add('  AND EQD_ESPRET = :ESPDOC     ');
      qryAux.SQL.Add('  AND EQD_EMPRET = :EMPDOC     ');
      qryAux.SQL.Add('  AND EQL_CODCLI = :CODCLI     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE                         ');
      qryAux.SQL.Add('  ACLDET                       ');
      qryAux.SQL.Add('INNER JOIN CONEQL C            ');
      qryAux.SQL.Add('  ON C.AUTOINCREM = EQD_SEQCON ');
      qryAux.SQL.Add('SET                            ');
      qryAux.SQL.Add('  EQD_NUMENV = NULL,           ');
      qryAux.SQL.Add('  EQD_ESPENV = NULL,           ');
      qryAux.SQL.Add('  EQD_EMPENV = NULL,           ');
      qryAux.SQL.Add('  EQD_SERENV = NULL            ');
      qryAux.SQL.Add('WHERE EQD_NUMENV = :NUMDOC     ');
      qryAux.SQL.Add('  AND EQD_ESPENV = :ESPDOC     ');
      qryAux.SQL.Add('  AND EQD_EMPENV = :EMPDOC     ');
      qryAux.SQL.Add('  AND EQL_CODCLI = :CODCLI     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE                         ');
      qryAux.SQL.Add('  ACLDET                       ');
      qryAux.SQL.Add('INNER JOIN CONEQL C            ');
      qryAux.SQL.Add('  ON C.AUTOINCREM = EQD_SEQCON ');
      qryAux.SQL.Add('SET                            ');
      qryAux.SQL.Add('  EQD_NUMRET = NULL,           ');
      qryAux.SQL.Add('  EQD_ESPRET = NULL,           ');
      qryAux.SQL.Add('  EQD_EMPRET = NULL,           ');
      qryAux.SQL.Add('  EQD_SERRET = NULL            ');
      qryAux.SQL.Add('WHERE EQD_NUMRET = :NUMDOC     ');
      qryAux.SQL.Add('  AND EQD_ESPRET = :ESPDOC     ');
      qryAux.SQL.Add('  AND EQD_EMPRET = :EMPDOC     ');
      qryAux.SQL.Add('  AND EQL_CODCLI = :CODCLI     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE                         ');
      qryAux.SQL.Add('  CONEQL C                     ');
      qryAux.SQL.Add('INNER JOIN EQLFAT              ');
      qryAux.SQL.Add('  ON EQF_SEQCON = C.AUTOINCREM ');
      qryAux.SQL.Add('SET EQL_STATUS = "A"           ');
      qryAux.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC     ');
      qryAux.SQL.Add('  AND EQF_ESPDOC = :ESPDOC     ');
      qryAux.SQL.Add('  AND EQF_EMPDOC = :EMPDOC     ');
      qryAux.SQL.Add('  AND EQL_CODCLI = :CODCLI     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE EQLDET                     ');
      qryAux.SQL.Add('INNER JOIN EQLFAT ON EQLDET.EQD_SEQCON = EQLFAT.EQF_SEQCON AND ');
      qryAux.SQL.Add('           EQLDET.EQD_SEQEQL = EQLFAT.EQF_SEQEQL               ');
      qryAux.SQL.Add(' SET EQD_DTAENC = NULL            ');
      qryAux.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC        ');
      qryAux.SQL.Add('  AND EQF_ESPDOC = :ESPDOC        ');
      qryAux.SQL.Add('  AND EQF_EMPDOC = :EMPDOC        ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE EQLFAT, (SELECT EQLDET.EQD_SEQEQL, ');
      qryAux.SQL.Add('                       F.EQF_SEQCON ');
      qryAux.SQL.Add('                FROM EQLFAT F       ');
      qryAux.SQL.Add('                INNER JOIN EQLDET ON EQLDET.EQD_SEQCON = F.EQF_SEQCON AND ');
      qryAux.SQL.Add('                                     EQLDET.EQD_SEQEQL = F.EQF_SEQEQL     ');
      qryAux.SQL.Add('                WHERE F.EQF_NUMDOC = :NUMDOC                              ');
      qryAux.SQL.Add('                  AND F.EQF_ESPDOC = :ESPDOC                              ');
      qryAux.SQL.Add('                  AND F.EQF_EMPDOC = :EMPDOC) AS EQFEQL                   ');
      qryAux.SQL.Add('SET EQLFAT.EQF_DTAENC = NULL ');
      qryAux.SQL.Add('WHERE EQLFAT.EQF_SEQCON = EQFEQL.EQF_SEQCON ');
      qryAux.SQL.Add('  AND EQF_SEQEQL = EQFEQL.EQD_SEQEQL');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE                            ');
      qryAux.SQL.Add('FROM                              ');
      qryAux.SQL.Add('  EQLFAT                          ');
      qryAux.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC        ');
      qryAux.SQL.Add('  AND EQF_ESPDOC = :ESPDOC        ');
      qryAux.SQL.Add('  AND EQF_EMPDOC = :EMPDOC        ');
      qryAux.SQL.Add('  AND EXISTS                      ');
      qryAux.SQL.Add('  (SELECT                         ');
      qryAux.SQL.Add('    1                             ');
      qryAux.SQL.Add('  FROM                            ');
      qryAux.SQL.Add('    CONEQL C                      ');
      qryAux.SQL.Add('  WHERE EQF_SEQCON = C.AUTOINCREM ');
      qryAux.SQL.Add('    AND EQL_CODCLI = :CODCLI)     ');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspSel;
      qryAux.ParamByName('EMPDOC').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ExecSQL;

      Result := True;

    Except
      Result := False;
      Raise;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TCancelarContratoLocacao.pLimparDadosEncerramentoDocumento(strCodEmp,
  strEspSel, strNumDoc, strCodCli: string);
var
  intCnt: Integer;
begin
  For intCnt := 0 to Contrato.Itens.Count-1 Do
  Begin
    If FobjValidaCtr.fTemItemFaturado(strCodEmp, strEspSel, strNumDoc, strCodCli,
      Contrato.Itens[intCnt].Equipamento.Codigo) Then
      Contrato.Itens[intCnt].DataEncerramento := 0;
  End;
end;

function TCancelarContratoLocacao.fDesvinculaContratoLocacaoRL(strNumDup, strEspDoc, strCodCli, strCodEmp: String; fltValDup: Double): Boolean;
Var
  qryConEql: TUniQuery;
  itemFatura: TFaturamentoContrato;
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  Result := False;

  If Not fVerificaAcessoSistema('CANCRL') Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para cancelar documentos da espécie RL.', ['&Ok']);
    Exit;
  End;

  qryConEql := fCriaQuery;
  Try
    Try
      qryConEql.SQL.Add('SELECT * FROM CONEQL');
      qryConEql.SQL.Add('JOIN EQLFAT ON EQF_SEQCON = CONEQL.AUTOINCREM');
      qryConEql.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC');
      qryConEql.SQL.Add('  AND EQF_ESPDOC = :ESPDOC');
      qryConEql.SQL.Add('  AND EQF_EMPDOC = :EMPDOC');
      qryConEql.SQL.Add('  AND EQL_CODCLI = :CODCLI');
      qryConEql.ParamByName('NUMDOC').AsString := strNumDup;
      qryConEql.ParamByName('ESPDOC').AsString := strEspDoc;
      qryConEql.ParamByName('EMPDOC').AsString := strCodEmp;
      qryConEql.ParamByName('CODCLI').AsString := strCodCli;
      qryConEql.Open;

      If qryConEql.IsEmpty Then
        Exit;

      itemFatura := fAddFatura;
      itemFatura.NumDoc := strNumDup;
      itemFatura.EspDoc := strEspDoc;
      itemFatura.EmpDoc := strCodEmp;
      itemFatura.SerDoc := qryConEql.FieldByName('EQF_SERDOC').AsString;
      itemFatura.pCarredaDadosAdiantamento(qryConEql.FieldByName('EQL_AUT_PD').AsString);

      pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
      Try
        frmCancelamentoDocumentos.edtCliFor.Text := strCodCli;
        frmCancelamentoDocumentos.edtDesCri.Text := strCodEmp;
        frmCancelamentoDocumentos.pCancelarDocumentoLocacaoEquipamento('RL', FFatura.strNumDocAdt, FFatura.strEmpDocAdt, strNumDup);
        Result := frmCancelamentoDocumentos.FblnCancelamentoComSucesso;
      Finally
        pFreeAndNil(frmCancelamentoDocumentos);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[pDesvinculaContratoLocacao]');
      End;
    End;
  Finally
    FreeAndNil(qryConEql);
  End;
end;

end.
