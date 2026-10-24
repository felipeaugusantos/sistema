unit untRelPedNecessidadeProducao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, Uni,
  ComCtrls, ToolWin, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untClassPanelCX,
  AppEvnts, untGeraExcel, untExcel, DB, BitBtnLockedIncrem,
  frxExportCSVTestabilidade;

type
  TfrmRelPedNecessidadeProducao = class(TfrmPaiRelatorio)
    mskDtaIni: TMaskEditFocus;
    Label12: TLabel;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtCodCliente: TEditFocus;
    Label2: TLabel;
    edtDesCliente: TEditFocus;
    edtCodPedido: TEditFocus;
    Label1: TLabel;
    edtDesPedido: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    rdgFiltroData: TRadioGroup;
    rdgOrdemData: TRadioGroup;
    rdgOrdemItens: TRadioGroup;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    pgbProgresso: TProgressBar;
    rdgQuebra: TRadioGroup;
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodPedidoExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);

    function fRetNomClientePed(Const strCodPed: String): String;
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pMontaTitGru(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelPedNecessidadeProducao: TfrmRelPedNecessidadeProducao;

implementation

uses untFuncoesFactory, untTypesSistema, untIFuncoes, untQckPedNecessidadeProducao,
System.StrUtils;

{$R *.dfm}

procedure TfrmRelPedNecessidadeProducao.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS '
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text)) Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;
end;

procedure TfrmRelPedNecessidadeProducao.edtCodPedidoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodPedido.Text) Then
    edtDesPedido.Text := 'TODOS '
  Else
    edtDesPedido.Text := fRetNomClientePed(edtCodPedido.Text);

  If fEmptyStr(edtDesPedido.Text) And (Not fEmptyStr(edtCodPedido.Text)) Then
  Begin
    fMensagem('AVISO','Código do pedido não encontrado.', ['&O K']);
    edtCodPedido.Clear;
    pSetFocus(edtCodPedido);
  End;
end;

procedure TfrmRelPedNecessidadeProducao.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;

begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedNecessidadeProducao.edtCodPedidoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    qryFatGor: TUniQuery;
    arrSel   : TConsultasArray;

begin
  inherited;
  qryFatGor := fCriaQuery(nil);

  If fPesqPedOrc(conPedCompleta, Self, 'PD', 'PD', VS_strCodEmp, edtCodPedido, nil, nil, qryFatGor, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryFatGor);

end;

procedure TfrmRelPedNecessidadeProducao.edtDestinoExit(Sender: TObject);
begin
  If edtDestino.Text <> 'E' Then inherited;
end;

procedure TfrmRelPedNecessidadeProducao.edtTipoExit(Sender: TObject);
begin
  inherited;
  rdgQuebra.Enabled := (edtTipo.Text = 'A');
end;

procedure TfrmRelPedNecessidadeProducao.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelPedNecessidadeProducao.edtCodEmpresaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedNecessidadeProducao.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodIte.Text) Then
    edtDesIte.Text := 'TODOS'
  Else
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

  edtDesIte.Enabled := False;

  If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&OK']);
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmRelPedNecessidadeProducao.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryConGen := fCriaQuery(nil);

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConGen, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryConGen);

end;

function TfrmRelPedNecessidadeProducao.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End
  
  Else
  If (Sender = edtTipo) Then
  Begin

    If (edtTipo.Text <> 'A') AND (edtTipo.Text <> 'S') Then
    Begin
      fMensagem('','O CAMPO TIPO DEVE CONTER A OU S ',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
    If Not fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelPedNecessidadeProducao.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodPedido.MaxLength := fTamDocCadRec;
  edtCodPedido.TamCampo  := fTamDocCadRec;

  inherited;
end;

procedure TfrmRelPedNecessidadeProducao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelPedNecessidadeProducao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmRelPedNecessidadeProducao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelPedNecessidadeProducao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedNecessidadeProducao.pCarregaCliente(Var qryCadCli: TUniQuery);
begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
end;

procedure TfrmRelPedNecessidadeProducao.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

//***************************************//
// RETORNA O NOME DO CLIENTE            *//
//************************************RL*//
function TfrmRelPedNecessidadeProducao.fRetNomClientePed(Const strCodPed: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON) AS "NOME" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + '  JOIN FATGOR ON FGO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC  ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strCodPed;
    Open;
    If Not IsEmpty Then
      Result := FieldByName('NOME').AsString
    Else
      Result := '';
    Close;
  End;
End;

procedure TfrmRelPedNecessidadeProducao.btnImprimirClick(Sender: TObject);
 Var
    strSQL: String;
  Const
    SQL_SALDOS = '(ITEGER.ITE_SALDOS + IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, ITEGER.ITE_SAL_ML / CADITE.ITE_CNV_ML, 0))';
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    {******************************}
    {* SELECT RELATORIO ANALITICO *}
    {***************************LB*}
    If edtTipo.Text = 'A' Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, FATDOR.FDO_CODITE, DETMAT.DMT_ITESUB) AS CODITE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, IF(CADITE.ITE_DESITE LIKE "%ITEM ESPECIAL%",FATDOR.FDO_DESCRI,CADITE.ITE_DESITE),IF(ITESUB.ITE_DESITE LIKE "%ITEM ESPECIAL%",FATDOR.FDO_DESCRI,ITESUB.ITE_DESITE)) AS DESITE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, CADITE.ITE_REFERE, ITESUB.ITE_REFERE) AS REFERE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, FDO_QTDITE - FDO_QTDBAI, DETMAT.DMT_QTDITE * (FATDOR.FDO_QTDITE - FATDOR.FDO_QTDBAI)) AS QTDITE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, CADUNI.UNI_DESUNI, UNISUB.UNI_DESUNI) AS DESUNI, ';
      strSQL := strSQL + '  FATDOR.FDO_DTAENT AS DTAENT, ';
      strSQL := strSQL + '  FATGOR.FGO_PREVIS AS PREVIS, ';
      strSQL := strSQL + '  CONCAT(CADCLI.CLI_CODCLI, "-", CADCLI.CLI_NOMCLI) AS NOMCLI, ';
      strSQL := strSQL + '  FATGOR.FGO_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  FATGOR.FGO_CODCLI AS CODCLI,  ';
      strSQL := strSQL + '  CONCAT(FATGOR.FGO_NUMDOC,"-",FATGOR.FGO_ESPDOC) AS NUMDOC ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR ';
      strSQL := strSQL + '  JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
      strSQL := strSQL + '  JOIN CADCLI ON FATGOR.FGO_CODCLI = CADCLI.CLI_CODCLI ';

      strSQL := strSQL + '  LEFT JOIN GERMAT         ON GERMAT.GMT_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN DETMAT         ON DETMAT.DMT_SEQGER = GERMAT.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN CADITE ITESUB  ON DETMAT.DMT_ITESUB = ITESUB.ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADUNI UNISUB  ON ITESUB.ITE_CODUNI = UNISUB.UNI_CODUNI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FATGOR.FGO_ESPDOC = "PD"              AND ';
      strSQL := strSQL + '  FATGOR.FGO_JAFATU = 0                 AND ';

      strSQL := strSQL + ' IF(GERMAT.GMT_CODITE IS NULL, FDO_QTDITE - FDO_QTDBAI, '+
                         ' DETMAT.DMT_QTDITE * (FATDOR.FDO_QTDITE - FATDOR.FDO_QTDBAI)) > 0 AND ';

      If rdgFiltroData.ItemIndex = 0 Then
        strSQL := strSQL + ' FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN '
      Else
        strSQL := strSQL + ' FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtCodCliente.Text) Then
        strSQL := strSQL + '  AND FATGOR.FGO_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtCodPedido.Text) Then
        strSQL := strSQL + '  AND FATGOR.FGO_NUMDOC = :NUMDOC ';

      If Not fEmptyStr(edtCodIte.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODITE = :CODITE ';


      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND FATGOR.FGO_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  AND LOCATE(FATGOR.FGO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + ' AND FDO_VLRCON <> 0 ';

      strSQL := strSQL + 'ORDER BY ';

      If rdgQuebra.ItemIndex = 0 Then
      Begin
        strSQL := strSQL + '  NOMCLI, ' + IfThen(rdgOrdemItens.ItemIndex = 0, 'CODITE', 'DESITE');
      End
      Else
      Begin
        If rdgOrdemData.ItemIndex = 0 Then
          strSQL := strSQL + '  FATGOR.FGO_DTAENT, FATGOR.FGO_NUMDOC, ' + IfThen(rdgOrdemItens.ItemIndex = 0, 'CODITE', 'DESITE')
        Else
          strSQL := strSQL + '  FATGOR.FGO_PREVIS, FATGOR.FGO_NUMDOC, ' + IfThen(rdgOrdemItens.ItemIndex = 0, 'CODITE', 'DESITE');
      End;

    End

    {******************************}
    {* SELECT RELATORIO SINTETICO *}
    {***************************LB*}
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, FATDOR.FDO_CODITE, DETMAT.DMT_ITESUB) AS CODITE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, IF(CADITE.ITE_DESITE = "ITEM ESPECIAL",FATDOR.FDO_DESCRI,CADITE.ITE_DESITE),IF(ITESUB.ITE_DESITE = "ITEM ESPECIAL",FATDOR.FDO_DESCRI,ITESUB.ITE_DESITE)) AS DESITE, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, CADITE.ITE_REFERE, ITESUB.ITE_REFERE) AS REFERE, ';
      strSQL := strSQL + '  SUM(IF(GERMAT.GMT_CODITE IS NULL, FDO_QTDITE - FDO_QTDBAI, DETMAT.DMT_QTDITE * (FATDOR.FDO_QTDITE - FATDOR.FDO_QTDBAI))) AS QTDITE, ';
      strSQL := strSQL + '  SUM(IFNULL(' + SQL_SALDOS + ', 0)) AS SALDOS, ';
      strSQL := strSQL + '  IF(GERMAT.GMT_CODITE IS NULL, CADUNI.UNI_DESUNI, UNISUB.UNI_DESUNI) AS DESUNI ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR ';
      strSQL := strSQL + '  JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
      strSQL := strSQL + '  JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN CADCLI ON FATDOR.FDO_CODCLI = CADCLI.CLI_CODCLI ';

      strSQL := strSQL + '  LEFT JOIN GERMAT        ON GERMAT.GMT_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN DETMAT        ON DETMAT.DMT_SEQGER = GERMAT.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN CADITE ITESUB ON DETMAT.DMT_ITESUB = ITESUB.ITE_CODITE ';
      strSQL := strSQL + '  LEFT JOIN CADUNI UNISUB ON ITESUB.ITE_CODUNI = UNISUB.UNI_CODUNI ';
      strSQL := strSQL + '     JOIN ITEGER          ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE '+
                         '                         AND ITEGER.ITE_CODEMP = CADITE.ITE_CODEMP ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' FATGOR.FGO_ESPDOC = "PD"              AND ';
      strSQL := strSQL + ' FATDOR.FDO_JAFATU = 0                 AND ';
      strSQL := strSQL + ' IF(GERMAT.GMT_CODITE IS NULL, FDO_QTDITE - FDO_QTDBAI, '+
                         ' DETMAT.DMT_QTDITE * (FATDOR.FDO_QTDITE - FATDOR.FDO_QTDBAI)) > 0 AND ';

      If rdgFiltroData.ItemIndex = 0 Then
        strSQL := strSQL + ' FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN '
      Else
        strSQL := strSQL + ' FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtCodCliente.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtCodPedido.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_NUMDOC = :NUMDOC ';

      If Not fEmptyStr(edtCodIte.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODITE = :CODITE ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  AND LOCATE(FATDOR.FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      strSQL := strSQL + ' AND FDO_VLRCON <> 0 ';

      strSQL := strSQL + '  GROUP BY CODITE  ';

      strSQL := strSQL + 'ORDER BY ' + IfThen(rdgOrdemItens.ItemIndex = 0, 'CODITE', 'DESITE');

    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQl);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtCodPedido.Text) Then
        ParamByName('NUMDOC').AsString := edtCodPedido.Text;

      If Not fEmptyStr(edtCodIte.Text) Then
        ParamByName('CODITE').AsString := edtCodIte.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' then
        pGeraExcel(qryRelatorio)
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckPedNecessidadeProducao,frmQckPedNecessidadeProducao);

          frmQckPedNecessidadeProducao.dtsRelatorio.DataSet := qryRelatorio;

          If strTipImp = 'M' Then
            frmQckPedNecessidadeProducao.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckPedNecessidadeProducao.qckPagina.DefaultFilter := Nil;


          {********************}
          {* CABEÇALHO DO QCK *}
          {*****************LB*}

          frmQckPedNecessidadeProducao.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If Not fEmptyStr(edtCodCliente.Text) Then
            frmQckPedNecessidadeProducao.rllCliente.Caption := 'CLIENTE: ' + edtCodCliente.Text + '-' + edtDesCliente.Text
          Else
            frmQckPedNecessidadeProducao.rllCliente.Caption := 'CLIENTE: TODOS ';

          If Not fEmptyStr(edtCodPedido.Text) Then
            frmQckPedNecessidadeProducao.rllPedido.Caption := 'PEDIDO ' + edtCodPedido.Text + '-' + edtDesPedido.Text
          Else
            frmQckPedNecessidadeProducao.rllPedido.Caption := 'PEDIDO: TODOS ';

          If Not fEmptyStr(edtCodIte.Text) Then
            frmQckPedNecessidadeProducao.rllProduto.Caption := 'PRODUTO ' + edtCodIte.Text + '-' + edtDesIte.Text
          Else
            frmQckPedNecessidadeProducao.rllProduto.Caption := 'PRODUTO: TODOS ';

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            frmQckPedNecessidadeProducao.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text
          Else
            frmQckPedNecessidadeProducao.rllEmpresa.Caption := 'EMPRESA: TODOS ';

          If edtTipo.Text = 'A' Then
          Begin
            frmQckPedNecessidadeProducao.rllNomeRelatorio.Caption := 'RELATORIO DE NECESSIDADE DE PRODUCAO - ANALITICO ';
            frmQckPedNecessidadeProducao.rlbTitulo.Visible := True;
            frmQckPedNecessidadeProducao.rlbGrupo.Visible  := True;

            If rdgQuebra.ItemIndex = 0 Then
            Begin
              frmQckPedNecessidadeProducao.rlbGrupo.DataFields := 'NOMCLI';
              frmQckPedNecessidadeProducao.rlbTitCli.Visible := True;
              frmQckPedNecessidadeProducao.rlbTituloGrupo.Visible := False;
            End
            Else
              frmQckPedNecessidadeProducao.rlbGrupo.DataFields := 'NUMDOC';

          End
          Else
          Begin
            frmQckPedNecessidadeProducao.rllNomeRelatorio.Caption := 'RELATORIO DE NECESSIDADE DE PRODUCAO - SINTETICO ';
            frmQckPedNecessidadeProducao.rlbTituloSint.Visible    := True;
            frmQckPedNecessidadeProducao.rlbDetalhe.Visible       := True;
          End;

          If edtDestino.Text = 'V' Then
            frmQckPedNecessidadeProducao.qckPagina.PreviewModal
          Else
            frmQckPedNecessidadeProducao.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;

        pFreeAndNil(frmQckPedNecessidadeProducao);
      End;

    End
    Else
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);

end;

procedure TfrmRelPedNecessidadeProducao.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

  objGeraExcel.strNomRel := 'RELATORIO DE NECESSIDADE DE PRODUCAO (' + IfThen(edtTipo.Text = 'A', 'ANALITICO', 'SINTETICO') + ')';

  objGeraExcel.AddFiltro('PERIODO: DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));
  objGeraExcel.AddFiltro('CLIENTE: '    + IfThen(fEmptyStr(edtCodCliente.Text), 'TODOS', edtCodCliente.Text + '-' + edtDesCliente.Text));
  objGeraExcel.AddFiltro('PEDIDO: '     + IfThen(fEmptyStr(edtCodPedido.Text), 'TODOS', edtCodPedido.Text + '-' + edtDesPedido.Text));
  objGeraExcel.AddFiltro('PRODUTO: '    + IfThen(fEmptyStr(edtCodIte.Text), 'TODOS', edtCodIte.Text + '-' + edtDesIte.Text));
  objGeraExcel.AddFiltro('EMPRESA: '    + IfThen(fEmptyStr(edtCodEmpresa.Text), 'TODAS', edtCodEmpresa.Text + '-' + edtDesEmpresa.Text));

  objGeraExcel.AddCampo( 'CODITE', 'CODIGO');
  objGeraExcel.AddCampo( 'DESITE', 'DESCRICAO');
  objGeraExcel.AddCampo( 'REFERE', 'REFERENCIA');
  objGeraExcel.AddCampo( 'DESUNI', 'UNIDADE');
  objGeraExcel.AddCampo( 'QTDITE', 'QUANTIDADE');

  If edtTipo.Text = 'S' Then
    objGeraExcel.AddCampo( 'SALDOS', 'SALDOS')
  Else
  Begin
    If rdgQuebra.ItemIndex = 0 Then
      objGeraExcel.AddQuebra('NOMCLI', 'CLIENTE: ')
    Else
      objGeraExcel.AddQuebra('NUMDOC', 'DOCUMENTO: ')
  End;

  objGeraExcel.OnImpTitGrupo := pMontaTitGru;

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);

end;

procedure TfrmRelPedNecessidadeProducao.pMontaTitGru(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel, Dados Do
  Begin
    If Quebra.NomeCampo = 'NUMDOC' Then
    Begin
      Escrever(LinhaAtual, 01, 'DOCUMENTO: '   + FieldByName('NUMDOC').AsString + ' ' +
                               'EMPRESA: '     + FieldByName('CODEMP').AsString + ' ' +
                               'ENTRADA: '  + FieldByName('DTAENT').AsString + ' ' +
                               'PREVISAO: ' + FieldByName('PREVIS').AsString);

      Escrever(ProximaLinha,  01, 'CLIENTE..: '   + FieldByName('NOMCLI').AsString);

      Negrito (LinhaAtual   , 01, True);
      Negrito (LinhaAtual -1, 01, True);

      Mesclar ('A' + IntToStr(LinhaAtual   ), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      CorFundo('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);
    End;
  End;
end;

end.

