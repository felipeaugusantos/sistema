unit untEntSelDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, DB,   Uni,
  UniClientDataSet, UniDataSetProvider, Mask, DBCtrls, BitBtnLockedIncrem, MemDS, DBAccess,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmEntSelDocumentos = class(TfrmPai)
    pnlTitulo: TPanel;
    pnlDadosInformativos: TPanel;
    Label21: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    dbgPedidos: TDBGridCitel;
    qryDocumentos: TUniQuery;
    dtsDocumentos: TDataSource;
    dspDocumentos: TUniDataSetProvider;
    cdsDocumentos: TUniClientDataSet;
    dbeTotIte: TDBEdit;
    dbeTotIcm: TDBEdit;
    dbeTotIpi: TDBEdit;
    dbeVlrCon: TDBEdit;
    pnlFiltro: TPanel;
    Label3: TLabel;
    edtNumDoc: TEditFocus;
    Label8: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnFiltros: TBitBtnLocked;
    btnFiltrar: TBitBtnLocked;
    btnLimpFiltros: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosTitleClick(Column: TColumn);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnFiltrosClick(Sender: TObject);
    procedure btnLimpFiltrosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strSQL: String;
    strIndice: String;
    stlSelecionados: TStringList;

    FblnAcessadoViaRetornoConsignacao : Boolean;

    procedure pAdicionaAggregate;
    procedure pAplicarIndice;
    procedure pSelecionaDocumento;

    procedure pRetFiltroDatas(var strDtaIni, strDtaFin: String);
  public
    { Public declarations }
    strDocsSel: String;

    strCodVen: String;
    strCodRep: String;
    strCodCli: String;
    strCodFaz: String;
    strCgccon: String;

    property blnAcessadoViaRetornoConsignacao : Boolean  read FblnAcessadoViaRetornoConsignacao  write FblnAcessadoViaRetornoConsignacao;
  end;

var
  frmEntSelDocumentos: TfrmEntSelDocumentos;

implementation

uses untFuncoes, untFuncoesSimples, untFatDigDatas, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmEntSelDocumentos.FormShow(Sender: TObject);
  Var
    strDtaIni: String;
    strDtaFin: String;
begin
  inherited;
  stlSelecionados := TStringList.Create;

  strCodFaz := '';
  strCgccon := '';

  pRetFiltroDatas(strDtaIni,strDtaFin);
  pMontaSQLNota(strSQL,strDtaIni,strDtaFin, FblnAcessadoViaRetornoConsignacao);

  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.Open;
  pAdicionaAggregate;
  cdsDocumentos.Open;

  TFloatField(cdsDocumentos.FieldByName('GER_TOTPRO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocumentos.FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocumentos.FieldByName('GER_TOTICM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocumentos.FieldByName('GER_TOTIPI')).DisplayFormat := '#,##0.00';

  dbgPedidosTitleClick(dbgPedidos.Columns[0]);
end;

procedure TfrmEntSelDocumentos.pAdicionaAggregate;
  procedure pNovoAgg(strField, strFieldName, strExpression, strDispFormat: String);
  begin
    With TAggregateField.Create(Self) Do
    Begin
      Name          := strField;
      FieldName     := strFieldName;
      Expression    := strExpression;
      DisplayFormat := strDispFormat;
      DataSet       := cdsDocumentos;
      Active        := True;
      Alignment     := taRightJustify;
    End;
  end;
begin

  pNovoAgg('TOT_TOTPRO', 'TOT_TOTPRO', 'SUM(GER_TOTPRO)', '#,##0.00');
  pNovoAgg('TOT_VLRCON', 'TOT_VLRCON', 'SUM(GER_VLRCON)', '#,##0.00');
  pNovoAgg('TOT_TOTICM', 'TOT_TOTICM', 'SUM(GER_TOTICM)', '#,##0.00');
  pNovoAgg('TOT_TOTIPI', 'TOT_TOTIPI', 'SUM(GER_TOTIPI)', '#,##0.00');

end;

procedure TfrmEntSelDocumentos.pAplicarIndice;
begin
  cdsDocumentos.IndexFieldNames := strIndice;
end;

procedure TfrmEntSelDocumentos.dbgPedidosTitleClick(Column: TColumn);
  Var
    intContador : integer;
begin
  strIndice := Column.FieldName;
  pAplicarIndice;

  {*************************************}
  {* DEIXANDO TODAS AS COLUNAS BRANCAS *}
  {**********************************LU*}
  for intcontador := 0 to dbgPedidos.Columns.count-1 do
  begin
    dbgPedidos.Columns[intContador].Color := clWhite;
  end;

  {*******************************************}
  {* COLOCANDO AMARELO NA COLUNA SELECIONADA *}
  {****************************************LU*}
  column.Color := clInfoBk;
  cdsDocumentos.First;
  inherited;
end;

procedure TfrmEntSelDocumentos.btnFiltrarClick(Sender: TObject);
  Var
    strFiltro: String;
    function E: String;
    begin
      If fEmptyStr(strFiltro) Then
        Result := ''
      Else
        Result := ' AND ';
    end;
begin
  inherited;

  strFiltro := '';

  If (Not fEmptyStr(edtNumDoc.Text)) Then
    strFiltro := strFiltro + 'GER_NUMDOC = ' + QuotedStr(edtNumDoc.Text);

  If (Not fEmptyStr(edtCodCli.Text)) Then
    strFiltro := strFiltro + E + 'GER_CODCLI = ' + QuotedStr(edtCodCli.Text);

  If (Not fEmptyStr(edtNomCli.Text)) Then
    strFiltro := strFiltro + E + 'CLI_NOMCLI Like ' + QuotedStr(edtNomCli.Text + '%');

  If (Not fEmptyStr(strFiltro)) Then
  Begin
    cdsDocumentos.Filter := strFiltro;
    cdsDocumentos.Filtered := False;
    cdsDocumentos.Filtered := True;
  End
  Else
    cdsDocumentos.Filtered := False;

  pSetFocus(dbgPedidos);

end;

procedure TfrmEntSelDocumentos.btnFiltrosClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmEntSelDocumentos.btnLimpFiltrosClick(Sender: TObject);
begin
  inherited;
  cdsDocumentos.Filter := '';
  cdsDocumentos.Filtered := False;

  pSetFocus(dbgPedidos);
end;

procedure TfrmEntSelDocumentos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgPedidos);
end;

procedure TfrmEntSelDocumentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(stlSelecionados);
end;

procedure TfrmEntSelDocumentos.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  FblnAcessadoViaRetornoConsignacao := False;
end;

procedure TfrmEntSelDocumentos.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pSelecionaDocumento;
  End
  Else If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else If Key = VK_F3 Then
  Begin
    btnFiltros.Click;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End
end;

procedure TfrmEntSelDocumentos.pSelecionaDocumento;
  Var
    intIndex: Integer;
begin
  intIndex := stlSelecionados.IndexOf(fChaveDocumentoEntradaMercadorias(cdsDocumentos));

  If (fEmptyStr(strCodCli)) Or (strCodCli = cdsDocumentos.FieldByName('GER_CODCLI').AsString) Then
  Begin
    If (Not fEmptyStr(strCodCli)) And fCfgSis('CADFAZ', VarBoolean) And
       (strCodFaz <> cdsDocumentos.FieldByName('GER_CODFAZ').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Só é permitido selecionar documentos da mesma Fazenda.', ['&Ok']);
      Exit;
    End;

    If (Not fEmptyStr(strCodCli)) And (strCgccon <> cdsDocumentos.FieldByName('GER_CGCCON').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Só é permitido selecionar documentos do mesmo Cliente/Consumidor.', ['&Ok']);
      Exit;
    End;

    If intIndex > -1 Then
      stlSelecionados.Delete(intIndex)
    Else
      stlSelecionados.Add(fChaveDocumentoEntradaMercadorias(cdsDocumentos));

    If stlSelecionados.Count > 0 Then
    Begin
      strCodCli := cdsDocumentos.FieldByName('GER_CODCLI').AsString;

      If fCfgSis('CADFAZ', VarBoolean) Then
        strCodFaz := cdsDocumentos.FieldByName('GER_CODFAZ').AsString;

      strCgccon := cdsDocumentos.FieldByName('GER_CGCCON').AsString;
    End
    Else
    Begin
      strCodCli := '';
      strCodFaz := '';
      strCgccon := '';
    End;
      
    dbgPedidos.Refresh;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Só é permitido selecionar documentos do mesmo cliente.', ['&Ok']);
  End;

end;

procedure TfrmEntSelDocumentos.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If stlSelecionados.IndexOf(fChaveDocumentoEntradaMercadorias(cdsDocumentos)) > -1 Then
    dbgPedidos.Canvas.Font.Color := clBlue;

  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEntSelDocumentos.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If stlSelecionados.Count <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um documento.', ['&Ok']);
    Exit;
  End;

  cdsDocumentos.First;

  strDocsSel := stlSelecionados.CommaText;

  strCodVen := cdsDocumentos.FieldByName('GER_CODVEN').AsString;
  strCodRep := cdsDocumentos.FieldByName('GER_CODREP').AsString;

  ModalResult := mrOk;
end;


procedure TfrmEntSelDocumentos.pRetFiltroDatas(Var strDtaIni: String; Var strDtaFin: String);
  Var
    blnResult: Boolean;
begin
  Try
    pCriarFormularios(TfrmFatDigDatas, frmFatDigDatas);

    frmFatDigDatas.mskDtaIni.Text := DateToStr(VS_Date - 15);
    frmFatDigDatas.mskDtaFin.Text := DateToStr(VS_Date);

    frmFatDigDatas.showModal;

    blnResult := frmFatDigDatas.blnConfirma;
    strDtaIni := frmFatDigDatas.mskDtaIni.Text;
    strDtaFin := frmFatDigDatas.mskDtaFin.Text;
  Except
    On E: Exception Do
    Begin
      blnResult := False;
      pMensagensErro(E.Message, '[fDigDadosDevolucao]');
    End;
  End;

  pFreeAndNil(frmFatDigDatas);

  If blnResult Then
  Begin
    strDtaIni := fCurrentDate(strToDate(strDtaIni));
    strDtaFin := fCurrentDate(strToDate(strDtaFin));
  End
  Else
  Begin
    strDtaIni := fCurrentDate(VS_DATE - 15);
    strDtaFin := fCurrentDate(VS_DATE);
    fMensagem('','Serão exibidas somente as Notas Fiscais emitidas nos últimos 15 dias!', ['&Ok']);
  End;

end;

end.
