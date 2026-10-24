unit untFatExpedicaoSubItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, UniDataSetProvider, UniClientDataSet, StrUtils,
  MaskUtils, AppEvnts, frxClass, frxDBSet, BitBtnLockedIncrem, untMovCdb,
  TypInfo, untIteBar, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, untLiberacao;

type
  TfrmFatExpedicaoSubItens = class(TfrmPai)
    pnlGeral: TPanel;
    dbgSubitens: TDBGridCitel;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    edtCodIte: TEditFocus;
    Label2: TLabel;
    edtQtdIte: TEditFocus;
    dtsSubitens: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    btnMarcarTudo: TBitBtnLocked;
    procedure dbgSubitensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcarTudoClick(Sender: TObject);
    procedure btnExpAutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    strValBus: String;
    strTipBus: String;
    strCamBus: String;
    intDecQtd: Integer;
    blnFecharESC: Boolean;

    function fTotalmenteExpedido(): Boolean;

    function fField(AName: String): TField;

    procedure pDefinirTipoBuscaSubItem(blnValidaTrava: Boolean = true);

    procedure pExpedeSubItem(blnValidaTrava: Boolean = true);
    procedure pCarregaSubItensPedido;
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);

    function fEncontraSubItem(Var strMensagem: String): Boolean;

    procedure pOnEncontrouSubItemQtdeMenorIgual(var strMensagem: String; fltEmbala: Double);
    procedure pOnEncontrouSubItemQtdeMaior(var strMensagem: String; strCodItem: String; fltQtdIte: Double);

    function fGetMensagemSubItemNaoEncontrado(): String;

    procedure pExibirMensagemBuscaSubItem(blnAchou: Boolean; var strMensagem: String);

    procedure pMarcarTodosSubitens;

    function fcdsSubItens : Boolean;
    function fSubItem : Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = true): Boolean; override;

  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodBarrasExp: String;
    strSQLFiltroProdutosExpedicaoItens: String;
    blnConferido: Boolean;
    cdsSubitens: TUniClientDataSet;
  end;

implementation

uses untfuncoesSimples, untConstantes, untFuncFat, untTypesSistema, untFuncoes, untFatGor;

{$R *.dfm}

Const
  ITEM_ESTRUTURA = '00000';

function TfrmFatExpedicaoSubItens.fSubItem: Boolean;
begin

  Result := False;

  If (Length(edtCodIte.Text) <= fTamCodIte) Then
    Exit(True);

  If (strCamBus = 'CODITE') Then
    Exit(True);

end;

function TfrmFatExpedicaoSubItens.fTotalmenteExpedido: Boolean;
begin
  inherited;
  Result := true;
  cdsSubitens.First;
  While (Not cdsSubitens.Eof) Do
  Begin
    If (fFormataFloat(fField('QTDITE').AsFloat, intDecQtd) <> fFormataFloat(fField('QTDEXP').AsFloat,
      intDecQtd)) Then
    Begin
      Result := False;
      Break;
    End;
    cdsSubitens.Next;
  End;
  cdsSubitens.First;
end;

function TfrmFatExpedicaoSubItens.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := true;

  If (Sender = edtCodIte) Then
  Begin
    Result := true;
  End

  Else If (Sender = edtQtdIte) Then
  Begin
    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And Assigned(edtQtdIte.OnKeyPress) Then
    Begin
      { ********************************************************************** }
      { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
      { SEM APAGAR A VÍRGULA DA MÁSCARA }
      { *******************************************************************VA* }
      fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse subitem!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pSetFocus(edtCodIte);
      edtQtdIte.Enabled := False;
      blnMudarFoco := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatExpedicaoSubItens.pExpedeSubItem(blnValidaTrava: Boolean = true);
Var
  strMensagem: String;
  blnAchou: Boolean;
begin
  blnMudarFoco := False;

  pDefinirTipoBuscaSubItem(blnValidaTrava);

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  strMensagem := '';

  strValBus := edtCodIte.Text;
  cdsSubitens.DisableControls;

  blnAchou := fEncontraSubItem(strMensagem);

  If (Not blnAchou) Then
    If (Length(edtCodIte.Text) > fTamCodIte) Then
    Begin
      strCamBus := 'CODBAR';
      blnAchou := fEncontraSubItem(strMensagem);
    End;

  cdsSubitens.EnableControls;

  pExibirMensagemBuscaSubItem(blnAchou, strMensagem);

  edtCodIte.Clear;
  lblCodBar.Caption := CAP_CODBAR_EMB;
end;

procedure TfrmFatExpedicaoSubItens.dbgSubitensDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  { ********************************** }
  { CONFIGURACAO DE COR P/ SELECAO }
  { *******************************IV* }
  If Not fcdsSubItens Then
    Exit;

  If cdsSubitens.FieldByName('CODITE').AsString = ITEM_ESTRUTURA Then
  Begin
    dbgSubitens.Canvas.Brush.Color := clSilver;
    dbgSubitens.Canvas.Font.Color := clBlack;
    dbgSubitens.Canvas.Font.Style := [fsBold];
    dbgSubitens.Canvas.Font.Size := 10;
    dbgSubitens.Canvas.FillRect(Rect);
  End
  Else If (fFormataFloat(fField('QTDITE').AsFloat, intDecQtd) = fFormataFloat(fField('QTDEXP').AsFloat,
    intDecQtd)) Then
  Begin
    dbgSubitens.Canvas.Brush.Color := $0096CFA7;
  End
  Else
  Begin
    If (fFormataFloat(fField('QTDITE').AsFloat, intDecQtd) > fFormataFloat(fField('QTDEXP').AsFloat, intDecQtd)) Then
      If (fFormataFloat(fField('QTDEXP').AsFloat, intDecQtd) <> 0) Then
        dbgSubitens.Canvas.Brush.Color := $00CCFFFF;
  End;

  dbgSubitens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatExpedicaoSubItens.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If (blnFecharESC) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente sair?', ['&Sim', '&Não']) = 2 Then
    Begin
      blnFecharESC := False;
      Action := CaNone;
      Exit;
    End;
  End;

  inherited;
end;

procedure TfrmFatExpedicaoSubItens.FormCreate(Sender: TObject);
begin
  inherited;
  strCodEmp := '';

  intDecQtd := fCfgSis('DECQTD', varInteger);

  fFindColumnByName(dbgSubitens, 'QTDITE').Visible := fCfgSis('QTDEXP', varBoolean);

  If fFindColumnByName(dbgSubitens, 'QTDITE').Visible Then
    fFindColumnByName(dbgSubitens, 'DESITE').Width := fFindColumnByName(dbgSubitens, 'DESITE').Width -
      fFindColumnByName(dbgSubitens, 'QTDITE').Width;

  blnFecharESC := False;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodIte.MaxLength := 43;

end;

procedure TfrmFatExpedicaoSubItens.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsSubitens) Then
    FreeAndNil(cdsSubitens);
end;

procedure TfrmFatExpedicaoSubItens.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN:
      If ((ActiveControl) = edtCodIte) Then
      Begin
        pExpedeSubItem;
        If fTotalmenteExpedido() Then
          btnConfirma.Click;
      End;
    VK_ESCAPE:
      btnSair.Click;
    VK_F6:
      btnQuantidade.Click;
    VK_F7:
      btnExpAut.Click;
    VK_F9:
      btnMarcarTudo.Click;
    VK_F10:
      Begin
        Key := 0;
        btnConfirma.Click;
      End;
  End;

end;

procedure TfrmFatExpedicaoSubItens.btnExpAutClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('EXPAUT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  btnExpAut.Enabled := False;

  pMarcarTodosSubitens;

  btnConfirma.Click;

  btnExpAut.Enabled := true;
end;

procedure TfrmFatExpedicaoSubItens.btnMarcarTudoClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  pMarcarTodosSubitens;
end;

procedure TfrmFatExpedicaoSubItens.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := true;
  pSetFocus(edtQtdIte);
end;

procedure TfrmFatExpedicaoSubItens.btnSairClick(Sender: TObject);
begin
  blnFecharESC := true;
  inherited;
end;

procedure TfrmFatExpedicaoSubItens.pCarregaSubItensPedido;
Const
  SQL_BAREMB = '(SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) ' +
    ' FROM ITEBAR WHERE CADITE.ITE_CODITE = BAR_CODITE)';
Var
  qryItens: TUniQuery;
  strUltSeqFdo: String;
begin
  qryItens := fCriaQuery(nil);

  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT SQL_NO_CACHE ');
  qryItens.SQL.Add('  FATDOR.AUTOINCREM AS SEQFDO, ');
  qryItens.SQL.Add('  FATDOR.FDO_DESCRI AS ITEEST, ');
  qryItens.SQL.Add('  CONCAT(CADITE.ITE_CODITE, "-", CADITE.ITE_DESITE) AS DESITE, ');
  qryItens.SQL.Add('  CADITE.ITE_CODITE AS CODITE, ');
  qryItens.SQL.Add(' ((FDO_QTDITE - FDO_QTDBAI) * DMT_QTDITE) AS QTDITE, ');
  qryItens.SQL.Add('  UNI_SIGUNI AS UNIDAD, ');
  qryItens.SQL.Add('  0.0000 AS QTDEXP, ');
  qryItens.SQL.Add('  ITEGER.ITE_SALDOS AS SALEST, ');
  qryItens.SQL.Add('  CADITE.ITE_CODUNI, ');
  qryItens.SQL.Add('  "B" AS TIPBUS, ');
  qryItens.SQL.Add('  ' + SQL_BAREMB + ' AS BAREMB, ');
  qryItens.SQL.Add('  CADITE.ITE_EMBALA AS EMBALA,  ');
  qryItens.SQL.Add('  CADITE.ITE_CODBAR AS CODBAR   ');
  qryItens.SQL.Add('FROM  ');
  qryItens.SQL.Add('  FATDOR ');
  qryItens.SQL.Add('  INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
  qryItens.SQL.Add('  INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
  qryItens.SQL.Add('  INNER JOIN GERMAT ON GERMAT.GMT_CODITE = FATDOR.FDO_CODITE ');
  qryItens.SQL.Add('  INNER JOIN DETMAT ON DETMAT.DMT_SEQGER = GERMAT.AUTOINCREM ');
  qryItens.SQL.Add('  INNER JOIN CADITE ON CADITE.ITE_CODITE = DETMAT.DMT_ITESUB ');
  qryItens.SQL.Add('  INNER JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
  qryItens.SQL.Add('                   AND ITEGER.ITE_CODEMP = FATDOR.FDO_CODEMP ');
  qryItens.SQL.Add('  LEFT  JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ');
  qryItens.SQL.Add('WHERE TRUE ');
  qryItens.SQL.Add('  AND FDO_NUMDOC = :NUMDOC ');
  qryItens.SQL.Add('  AND FDO_ESPDOC = :ESPDOC ');
  qryItens.SQL.Add('  AND FDO_CODEMP = :CODEMP ');
  qryItens.SQL.Add('  AND FDO_BXSBIT = "S"     '); // Baixa os sub-itens da estrutura
  qryItens.SQL.Add(strSQLFiltroProdutosExpedicaoItens);
  qryItens.SQL.Add('ORDER BY ');
  qryItens.SQL.Add('  ITEEST,SEQFDO,CODITE ');

  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;

  qryItens.Open;

  If Assigned(cdsSubitens) Then
    FreeAndNil(cdsSubitens);

  cdsSubitens := fCriaClientDatSet(qryItens, true);

  cdsSubitens.IndexFieldNames := 'ITEEST;SEQFDO;CODITE';

  dtsSubitens.DataSet := cdsSubitens;

  strUltSeqFdo := '';

  qryItens.First;
  While Not qryItens.Eof Do
  Begin
    If strUltSeqFdo <> qryItens.FieldByName('SEQFDO').AsString Then
    Begin
      cdsSubitens.Append;
      cdsSubitens.FieldByName('CODITE').AsString := ITEM_ESTRUTURA;
      cdsSubitens.FieldByName('ITEEST').AsString := qryItens.FieldByName('ITEEST').AsString;
      cdsSubitens.FieldByName('DESITE').AsString := qryItens.FieldByName('ITEEST').AsString;
      cdsSubitens.FieldByName('SEQFDO').AsString := qryItens.FieldByName('SEQFDO').AsString;
      cdsSubitens.Post;
    End;
    strUltSeqFdo := qryItens.FieldByName('SEQFDO').AsString;
    pCopiaRegistroDataSet(qryItens, cdsSubitens);
    qryItens.Next;
  End;

  cdsSubitens.OnFilterRecord := pOnFilter;

  If cdsSubitens.IsEmpty Then
  Begin
    blnFecharForm := true;
    blnConferido := true;
  End;

  FreeAndNil(qryItens);
end;

procedure TfrmFatExpedicaoSubItens.pDefinirTipoBuscaSubItem(blnValidaTrava: Boolean = true);
Var
  objIteBar: TIteBar;
  blnBarExp: Boolean;
  strCodIteUni: String;
  strCodGruUni: String;
  fltQtdIteUni: Double;
begin

  If (Length(edtCodIte.Text) > fTamCodIte) Then
  Begin
    strCamBus := 'BAREMB';
    If (fCfgSis('ETIDIF', varBoolean)) Then
    Begin
      try
        objIteBar := TIteBar.Create;
        If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
        Begin
          edtCodIte.Text := strCodIteUni;
          edtQtdIte.Text := floatToStr(fltQtdIteUni);
          strCamBus := 'CODITE';
        End;
      Finally
        FreeAndNil(objIteBar);
      End;
    End;
    Exit;
  End;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    strCamBus := 'CODITE';
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);
    If blnValidaTrava Then
      If blnBarExp Then
      Begin
        edtCodIte.Clear;
        pMensagemSonora('Para expedir este subitem é necessário informar o código de barras.');
        Exit;
      End;
  End;

end;

procedure TfrmFatExpedicaoSubItens.FormShow(Sender: TObject);
begin
  inherited;
  blnFecharForm := False;
  blnConferido := False;

  edtQtdIte.EditFormat := fMskDigitos(intDecQtd);
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 1);

  pCarregaSubItensPedido;

  If Not fEmptyStr(strCodBarrasExp) Then
  Begin
    edtCodIte.Text := strCodBarrasExp;
    edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
    pExpedeSubItem;
  End;

  pSetFocus(edtCodIte);

  Caption := Caption + ' - ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp;
end;

procedure TfrmFatExpedicaoSubItens.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmFatExpedicaoSubItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not fTotalmenteExpedido) Then
  Begin
    fMensagem('', 'O documento não está completo!' + #13#10 + ' Por favor, verifique.', ['&Ok']);
    pSetFocus(edtCodIte);
  End
  Else
  Begin
    Close;
    blnConferido := true;
  End;
end;

procedure TfrmFatExpedicaoSubItens.pOnEncontrouSubItemQtdeMaior(var strMensagem: String; strCodItem: String;
  fltQtdIte: Double);
begin
  If (fltQtdIte > 1.0) Then
    strMensagem := 'Quantidade não permitida para o subitem (' + strCodItem + ').'
  Else
  Begin
    If (fField('QTDEXP').AsFloat < fField('QTDITE').AsFloat) And
      (fStrToFloat(edtQtdIte.Text) > fField('QTDITE').AsFloat) Then
      strMensagem := 'Quantidade não permitida para o subitem (' + strCodItem + ').'
    Else
    Begin
      If (fField('QTDEXP').AsFloat = fField('QTDITE').AsFloat) Then
        strMensagem := 'Subitem (' + strCodItem + ') já foi totalmente confirmado!'
      Else
        strMensagem := 'Quantidade não permitida para o subitem (' + strCodItem + ').'
    End;
  End;
end;

procedure TfrmFatExpedicaoSubItens.pOnEncontrouSubItemQtdeMenorIgual(var strMensagem: String;
  fltEmbala: Double);
begin
  If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And
    fItemNaoFracionavel('VN', fField('ITE_CODUNI').AsString) Then
  Begin
    { ********************************************************************** }
    { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
    { SEM APAGAR A VÍRGULA DA MÁSCARA }
    { *******************************************************************VA* }
    strMensagem := 'Não é permitido informar valor fracionado para esse subitem!';
  End
  Else
  Begin
    cdsSubitens.Edit;
    fField('QTDEXP').AsFloat := fField('QTDEXP').AsFloat + fltEmbala * fStrToFloat(edtQtdIte.Text);

    If (strCamBus = 'CODITE') Then
      fField('TIPBUS').AsString := 'C';

    cdsSubitens.Post;

    edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 1);
    strMensagem := '';
  End;
end;

procedure TfrmFatExpedicaoSubItens.pOnFilter(DataSet: TDataSet; var Accept: Boolean);
begin
  If SameText(strCamBus, 'BAREMB') Then
    Accept := Pos('-' + strValBus + '-', DataSet.FieldByName(strCamBus).AsString) > 0
  Else If strTipBus = '<>' Then
    Accept := (DataSet.FieldByName(strCamBus).AsString <> strValBus)
  Else
    Accept := (DataSet.FieldByName(strCamBus).AsString = strValBus);
end;

function TfrmFatExpedicaoSubItens.fcdsSubItens: Boolean;
begin

  If (Not Assigned(cdsSubitens)) Then
    Exit(False);

  If (Not cdsSubitens.Active) Then
    Exit(False);

  If (cdsSubitens.IsEmpty) Then
    Exit(False);

  Result := True;

end;

function TfrmFatExpedicaoSubItens.fEncontraSubItem(Var strMensagem: String): Boolean;
var
  fltQtdIte, fltEmbala: Double;
  strCodAux: String;
  objIteBar: TIteBar;
  fltTmpQtd: Double;
begin
  Result := False;

  Try
    objIteBar := TIteBar.Create(opcFuncoes);

    strCodAux := edtCodIte.Text;

    cdsSubitens.First;
    If (cdsSubitens.FindFirst) Then
    Begin
      Result := true;

      Repeat
        fltEmbala := 1;
        fltTmpQtd := fStrToFloat(edtQtdIte.Text);

        If SameText(strCamBus, 'BAREMB') Then
          fltEmbala := objIteBar.fQuantidadeEmbalagem(fField('CODITE').AsString, strValBus);

        fltQtdIte := fField('QTDEXP').AsFloat + fltEmbala * fStrToFloat(edtQtdIte.Text);

        if (strCamBus = 'BAREMB') then
          fltTmpQtd := fField('EMBALA').AsFloat;

        If (fField('QTDITE').AsFloat >= fltQtdIte) Then
        Begin
          pOnEncontrouSubItemQtdeMenorIgual(strMensagem, fltEmbala);
          Break;
        End
        Else
          pOnEncontrouSubItemQtdeMaior(strMensagem, strCodAux, fltTmpQtd);

      Until (Not cdsSubitens.FindNext);

    End;
  Finally
    FreeAndNil(objIteBar);
  End;
end;

function TfrmFatExpedicaoSubItens.fField(AName: String): TField;
begin
  Result := cdsSubitens.FieldByName(AName);
end;

function TfrmFatExpedicaoSubItens.fGetMensagemSubItemNaoEncontrado: String;
begin

  If (fSubItem) Then
  Begin
    If fCampoTabela('COUNT(*)', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) > 0 Then
      Result := 'Subitem (' + edtCodIte.Text + ') não encontrado no pedido!'
    Else
      Result := 'Subitem (' + edtCodIte.Text + ') não cadastrado no sistema!';
  End
  Else
  Begin
    if untIteBar.fCodigoDeBarrasExiste(edtCodIte.Text) then
      Result := 'Código de Barras (' + edtCodIte.Text + ') não encontrado no pedido!'
    else
      Result := 'Código de Barras (' + edtCodIte.Text + ') não cadastrado no sistema!';
  End
end;

procedure TfrmFatExpedicaoSubItens.pMarcarTodosSubitens;
var
  fltQtdIte: Double;
  cdsLista: TUniClientDataSet;
begin
  Try
    cdsLista := TUniClientDataSet.Create(Self);
    cdsLista.Data := cdsSubitens.Data;

    cdsLista.First;
    While Not cdsLista.Eof Do
    Begin
      fltQtdIte := cdsLista.FieldByName('QTDITE').AsFloat;
      If cdsLista.FieldByName('QTDEXP').AsFloat < fltQtdIte Then
      Begin
        edtCodIte.Text := cdsLista.FieldByName('CODITE').AsString;
        edtQtdIte.Text := FloatToStrF(fltQtdIte - cdsLista.FieldByName('QTDEXP').AsFloat, ffFixed, 12,
          intDecQtd);
        pExpedeSubItem(False);
      End;
      cdsLista.Next;
    End;

  Finally
    FreeAndNil(cdsLista);
  End;
end;

procedure TfrmFatExpedicaoSubItens.pExibirMensagemBuscaSubItem(blnAchou: Boolean; var strMensagem: String);
begin
  If Not blnAchou Then
    strMensagem := fGetMensagemSubItemNaoEncontrado();

  If (Not fEmptyStr(strMensagem)) Then
    fMensagem('', strMensagem, ['&OK']);
end;

End.
