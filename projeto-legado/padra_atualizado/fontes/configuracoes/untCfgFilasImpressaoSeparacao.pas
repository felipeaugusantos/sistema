unit untCfgFilasImpressaoSeparacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, DB, Grids, DBGrids, StdCtrls, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Provider, DBClient, Uni,
  BitBtnLockedIncrem,  QColorLabel, ComboBoxFocus, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet, DBGridCitel, UniDataSetProvider, StrUtils;

type
  TOpcaoFila = (ofPedido = 1, ofVenda = 2, ofOnda = 3);

  TOpcaoFilaHelper = record helper for TOpcaoFila
    function ToString: String;
  end;

  TfrmCfgFilasImpressaoSeparacao = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtNomImp: TEditFocus;
    dbgFilImp: TDBGridCitel;
    dtsFilImp: TDataSource;
    cdsFilImp: TUniClientDataSet;
    btnInserir: TBitBtnLocked;
    dspFilImp: TUniDataSetProvider;
    Label2: TLabel;
    edtDescri: TEditFocus;
    memWhere: TMemo;
    Label3: TLabel;
    spbShowSQL: TSpeedButton;
    btnSelImp: TSpeedButton;
    lblLayout: TLabel;
    edtCodLay: TEditFocus;
    edtDesLay: TEditFocus;
    cmbNomMaq: TComboBoxFocus;
    Label5: TLabel;
    ckbSolicitarImpressora: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgFilImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure memWhereKeyPress(Sender: TObject; var Key: Char);
    procedure memWhereEnter(Sender: TObject);
    procedure spbShowSQLClick(Sender: TObject);
    procedure dbgFilImpDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelImpClick(Sender: TObject);
    procedure edtCodLayKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaDescricaoLayout;
    procedure ckbSolicitarImpressoraClick(Sender: TObject);
    procedure dbgFilImpDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    qryFilas: TUniQuery;
    strRegAtu: String;
    opcFila: TOpcaoFila;

    procedure pCarregaFilas;
    function  fInsereFilasImp(strNomImp, strDescri, strWhere: String; Var strCodFil: String; strCodLay: String; const intSolImp : Integer): Boolean;
    function  fAtualizaFilasImp(strCodFil, strNomImp, strDescri, strWhere, strCodLay: String; const intSolImp : Integer): Boolean;
    function  fApagaFilasImp(strCodFil: String): Boolean;
    procedure pCarregarNomeMaquinas;
    procedure pHabilitarFilaImpressao;
    function fInformouFilaOuSelecaoDeImpressora : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untPai, untLeDocumento, untMemo,
  untTypesSistema, untCfgRel, untImpressaoSeparacao;

{$R *.dfm}

procedure TfrmCfgFilasImpressaoSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('ONDASE', varBoolean) Then
    opcFila := TOpcaoFila(fGetMenu('Escolha o Tipo de Documento', ['Orçamento/Pedido', 'Vendas', 'Onda'], 1))
  Else
    opcFila := TOpcaoFila(fGetMenu('Escolha o Tipo de Documento', ['Orçamento/Pedido', 'Vendas'], 1));

  case opcFila of
    ofPedido: Self.Caption := 'Filas de Impressão Separação (Orçamentos e Pedidos de Venda)';
    ofVenda : Self.Caption := 'Filas de Impressão Separação (Venda)';
    ofOnda  : Self.Caption := 'Filas de Impressão Separação (Onda)';
  end;

  if opcFila <> ofPedido then
  begin
    lblLayout.Visible := False;
    edtCodLay.Visible := False;
    edtDesLay.Visible := False;
    fFindColumnByName(dbgFilImp, 'FIL_CODLAY').Visible := False;
  end;

  qryFilas := fCriaQuery(Self);
  dspFilImp.DataSet := qryFilas;
  cdsFilImp.SetProvider(dspFilImp);
  dtsFilImp.DataSet := cdsFilImp;

  pCarregaFilas;
  pCarregarNomeMaquinas;
  strRegAtu := '';

  If VS_SpoolImpressaoCitel Then
  Begin
    edtNomImp.ReadOnly    := True;
    edtNomImp.TabStop     := False;
    edtNomImp.Color       := $00FFDFB8;
    edtNomImp.NormalColor := $00FFDFB8;
    edtNomImp.FocusColor  := $00FFDFB8;
    btnSelImp.Visible     := True;
  End;
end;

procedure TfrmCfgFilasImpressaoSeparacao.pCarregaDescricaoLayout;
begin
  if fEmptyStr(edtCodLay.Text) then
    Exit;

  edtCodLay.Text := fStrZero(edtCodLay.Text, edtCodLay.MaxLength);
  edtDesLay.Text := fCampoTabela('LAY_NOMLAY', 'LAYETI', ['LAY_CODEMP','LAY_CODLAY','LAY_TIPLAY'], [VS_strCodEmp, edtCodLay.Text, '55'], False);
end;

procedure TfrmCfgFilasImpressaoSeparacao.pCarregaFilas;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  FIL_CODFIL, ';
    strSQL := strSQL + '  FIL_CODEMP, ';
    strSQL := strSQL + '  FIL_NOMIMP, ';
    strSQL := strSQL + '  FIL_DESCRI, ';
    strSQL := strSQL + '  FIL_WHERE_, ';
    strSQL := strSQL + '  FIL_TIPDOC, ';
    strSQL := strSQL + '  FIL_CODLAY, ';
    strSQL := strSQL + '  FIL_NOMMAQ, ';
    strSQL := strSQL + '  FIL_SOLIMP, ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  FILSEP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND FIL_TIPDOC = :TIPDOC ';

    If VS_SpoolImpressaoCitel Then
      strSQL := strSQL + '  AND FIL_SPOIMP = "S" '
    Else
      strSQL := strSQL + '  AND FIL_SPOIMP <> "S" ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('TIPDOC').AsString := opcFila.ToString;
      Open;
      pSetaClient(qryFilas);
    End;

    cdsFilImp.Close;
    cdsFilImp.Open;
    pSetaClient(cdsFilImp);

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoSeparacao.pCarregaFilas]');
  End
end;

procedure TfrmCfgFilasImpressaoSeparacao.pEscapePressed;
begin
  If Not dbgFilImp.Enabled Then
  Begin
    dbgFilImp.Enabled := True;
    edtNomImp.Clear;
    edtDescri.Clear;
    memWhere.Clear;
    edtCodLay.Clear;
    edtDesLay.Clear;
    cmbNomMaq.ItemIndex := 0;
    ckbSolicitarImpressora.Checked := False;
    pHabilitarFilaImpressao;
    pSetFocus(edtDescri);
  End
  Else
    inherited;
end;

procedure TfrmCfgFilasImpressaoSeparacao.spbShowSQLClick(Sender: TObject);
  Var
    strSQL : String;
begin
  inherited;
  case opcFila of
    ofPedido,
    ofOnda:
      begin
        strSQL := fGetSQLSeparacao(EmptyStr, 'PD', VS_strCodEmp, EmptyStr, Trim(memWhere.Text), tpeSepPedido);
        TfrmMemo.pShowMessage(fFormatarSQL(strSQL), 10, True, 0, 0, True);
      end;
    ofVenda:
      begin
        strSQL := fGetSQLSeparacao(EmptyStr, 'NF', VS_strCodEmp, EmptyStr, Trim(memWhere.Text), tpeSepNota);
        TfrmMemo.pShowMessage(fFormatarSQL(strSQL), 10, True, 0, 0, True);
      end;
  end;
end;

procedure TfrmCfgFilasImpressaoSeparacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescri);
end;

procedure TfrmCfgFilasImpressaoSeparacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryFilas);
  
  inherited;
end;

procedure TfrmCfgFilasImpressaoSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  opcFila := ofPedido;
end;

procedure TfrmCfgFilasImpressaoSeparacao.btnInserirClick(Sender: TObject);
  var
    strCodFilIns: String;
    blnInformaLayout: Boolean;
begin
  inherited;

  strCodFilIns := '';
  blnInformaLayout := False;

  If fVerificaCampos Then
  Begin

    If (fInformouFilaOuSelecaoDeImpressora) And (dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Append;
        FieldByName('FIL_CODEMP').AsString := VS_strCodEmp;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_WHERE_').AsString := memWhere.Text;
        FieldByName('FIL_TIPDOC').AsString := opcFila.ToString;
        FieldByName('FIL_NOMMAQ').AsString := cmbNomMaq.Text;
        FieldByName('FIL_SOLIMP').AsInteger := IIF(ckbSolicitarImpressora.Checked, 1, 0);

        If (edtCodLay.Visible) Then
        Begin
          If (Not fEmptyStr(edtCodLay.Text)) Then
            FieldByName('FIL_CODLAY').AsString := edtCodLay.Text
          Else
            FieldByName('FIL_CODLAY').Clear;

          blnInformaLayout := True;
        End;

        Post;

        If fInsereFilasImp(edtNomImp.Text, edtDescri.Text, memWhere.Text, strCodFilIns, IIF(blnInformaLayout, edtCodLay.Text, ''), FieldByName('FIL_SOLIMP').AsInteger) Then
        Begin
          Edit;
          FieldByName('FIL_CODFIL').AsString := strCodFilIns;
          Post;
        End;
      End;

      edtNomImp.Clear;
      edtDescri.Clear;
      memWhere.Clear;
      edtCodLay.Clear;
      edtDesLay.Clear;
      cmbNomMaq.ItemIndex := 0;
      ckbSolicitarImpressora.Checked := False;
      pHabilitarFilaImpressao;
      pSetFocus(edtDescri);
    End
    Else If (fInformouFilaOuSelecaoDeImpressora) And (Not dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Edit;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_WHERE_').AsString := memWhere.Text;
        FieldByName('FIL_TIPDOC').AsString := opcFila.ToString;
        FieldByName('FIL_NOMMAQ').AsString := cmbNomMaq.Text;
        FieldByName('FIL_SOLIMP').AsInteger := IIF(ckbSolicitarImpressora.Checked, 1, 0);

        If (edtCodLay.Visible) Then
        Begin
          If (Not fEmptyStr(edtCodLay.Text)) Then
            FieldByName('FIL_CODLAY').AsString := edtCodLay.Text
          Else
            FieldByName('FIL_CODLAY').Clear;

          blnInformaLayout := True;
        End;

        Post;

        fAtualizaFilasImp(FieldByName('FIL_CODFIL').AsString, edtNomImp.Text, edtDescri.Text, memWhere.Text, IIF(blnInformaLayout, edtCodLay.Text, ''), FieldByName('FIL_SOLIMP').AsInteger);

        strRegAtu := '';
      End;

      dbgFilImp.Enabled := True;

      edtNomImp.Clear;
      edtDescri.Clear;
      memWhere.Clear;
      edtCodLay.Clear;
      edtDesLay.Clear;
      cmbNomMaq.ItemIndex := 0;
      ckbSolicitarImpressora.Checked := False;
      pHabilitarFilaImpressao;
      pSetFocus(edtDescri);
    End;

  End;

end;

procedure TfrmCfgFilasImpressaoSeparacao.btnSelImpClick(Sender: TObject);
begin
  inherited;
  edtNomImp.Text := TCfgRel.fSelecionaFila('', '', True, True);
end;

procedure TfrmCfgFilasImpressaoSeparacao.ckbSolicitarImpressoraClick(
  Sender: TObject);
begin
  inherited;
  pHabilitarFilaImpressao;
end;

procedure TfrmCfgFilasImpressaoSeparacao.dbgFilImpDblClick(Sender: TObject);
  Var
    Key: Word;
begin
  inherited;
  Key := VK_RETURN;
  dbgFilImpKeyDown(Sender, Key, []);
end;

procedure TfrmCfgFilasImpressaoSeparacao.dbgFilImpDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    strTexto : String;
begin
  inherited;
  If ((Column.Field.DataSet.RecNo Mod 2) = 0) Then
  Begin
    dbgFilImp.Canvas.Brush.Color := StrToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
    dbgFilImp.Canvas.FillRect(Rect);
    dbgFilImp.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
  If (Column.FieldName = 'FIL_SOLIMP') Then
  Begin
    If TIntegerField(Column.Field.DataSet.FieldByName('FIL_SOLIMP')).Value = 1 Then
      strTexto := 'Sim'
    Else
      strTexto := 'Não';
    dbgFilImp.Canvas.FillRect(Rect);
    dbgFilImp.Canvas.TextOut(Rect.Right - dbgFilImp.Canvas.TextWidth(strTexto) - 2, Rect.Top + 2, strTexto);
  End;
end;

procedure TfrmCfgFilasImpressaoSeparacao.dbgFilImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    strCodFil : String;
    intNomMaq : Integer;
begin
  inherited;

  strCodFil := '';

  {**********************************}
  {* MARCA O REGISTRO PARA EXCLUSÃO *}
  {*******************************PZ*}
  If (Key = VK_DELETE) And (Not cdsFilImp.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir a Fila de Impressão "' +
      cdsFilImp.FieldByName('FIL_DESCRI').AsString + '" ?', ['&Sim','&Não'], 2) = 1) Then
    Begin
      strCodFil := cdsFilImp.FieldByName('FIL_CODFIL').AsString;

      cdsFilImp.Delete;

      fApagaFilasImp(strCodFil);
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsFilImp.IsEmpty) Then
  Begin
    edtNomImp.Text    := cdsFilImp.FieldByName('FIL_NOMIMP').AsString;
    edtDescri.Text    := cdsFilImp.FieldByName('FIL_DESCRI').AsString;
    memWhere.Text     := cdsFilImp.FieldByName('FIL_WHERE_').AsString;
    ckbSolicitarImpressora.Checked := (cdsFilImp.FieldByName('FIL_SOLIMP').AsInteger = 1);
    intNomMaq := cmbNomMaq.Items.Indexof(cdsFilImp.FieldByName('FIL_NOMMAQ').AsString);
    cmbNomMaq.ItemIndex := 0;
    If (intNomMaq > 0) Then
      cmbNomMaq.ItemIndex := intNomMaq;
    If (edtCodLay.Visible) Then
    Begin
      edtCodLay.Text    := cdsFilImp.FieldByName('FIL_CODLAY').AsString;
      pCarregaDescricaoLayout;
    End;
    pHabilitarFilaImpressao;
    dbgFilImp.Enabled := False;
    dbgFilImp.Repaint;
    pSetFocus(edtDescri);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomImp.Clear;
    edtDescri.Clear;
    memWhere.Clear;
    edtCodLay.Clear;
    edtDesLay.Clear;
    ckbSolicitarImpressora.Checked := False;
    cmbNomMaq.ItemIndex := 0;
    pHabilitarFilaImpressao;
    pSetFocus(edtDescri);
  End;

end;

procedure TfrmCfgFilasImpressaoSeparacao.edtCodLayKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSelecao: TConsultasArray;
begin
  inherited;
  If fPesqLayout(Self, edtCodLay, edtDesLay, Nil, '', Key, arrSelecao, True, '55') Then
  Begin
    If fValidaCampos(edtCodLay) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCfgFilasImpressaoSeparacao.fApagaFilasImp(
  strCodFil: String): Boolean;
Var
  strSQL: String;
  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  FILSEP    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  FIL_CODFIL = :CODFIL AND ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoSeparacao.fApagaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoSeparacao.fAtualizaFilasImp(strCodFil, strNomImp, strDescri, strWhere, strCodLay: String; const intSolImp : Integer): Boolean;
Var
  strSQL: String;
  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  FILSEP ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  FIL_NOMIMP = :NOMIMP, ';
    strSQL := strSQL + '  FIL_DESCRI = :DESCRI, ';
    strSQL := strSQL + '  FIL_WHERE_ = :WHERE_, ';
    strSQL := strSQL + '  FIL_CODLAY = :CODLAY, ';
    strSQL := strSQL + '  FIL_TIPDOC = :TIPDOC, ';
    strSQL := strSQL + '  FIL_NOMMAQ = :NOMMAQ, ';
    strSQL := strSQL + '  FIL_SOLIMP = :SOLIMP  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FIL_CODFIL = :CODFIL AND ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('WHERE_').AsString := strWhere;

      If (Not fEmptyStr(strCodLay)) Then
        ParamByName('CODLAY').AsString := strCodLay
      Else
        ParamByName('CODLAY').Clear;

      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('TIPDOC').AsString := opcFila.ToString;
      ParamByName('NOMMAQ').AsString := cmbNomMaq.Text;
      ParamByName('SOLIMP').AsInteger := intSolImp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoSeparacao.fAtualizaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoSeparacao.fInsereFilasImp(strNomImp, strDescri, strWhere: String; Var strCodFil: String; strCodLay: String; const intSolImp : Integer): Boolean;
Var
  strSQL: String;

  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  FILSEP(             ';
    strSQL := strSQL + '         FIL_CODFIL,  ';
    strSQL := strSQL + '         FIL_CODEMP,  ';
    strSQL := strSQL + '         FIL_NOMIMP,  ';
    strSQL := strSQL + '         FIL_DESCRI,  ';
    strSQL := strSQL + '         FIL_WHERE_,  ';
    strSQL := strSQL + '         FIL_TIPDOC,  ';
    strSQL := strSQL + '         FIL_SPOIMP,  ';
    strSQL := strSQL + '         FIL_CODLAY,  ';
    strSQL := strSQL + '         FIL_NOMMAQ,  ';
    strSQL := strSQL + '         FIL_SOLIMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODFIL,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :NOMIMP,     ';
    strSQL := strSQL + '         :DESCRI,     ';
    strSQL := strSQL + '         :WHERE_,     ';
    strSQL := strSQL + '         :TIPDOC,     ';
    strSQL := strSQL + '         :SPOIMP,     ';
    strSQL := strSQL + '         :CODLAY,     ';
    strSQL := strSQL + '         :NOMMAQ,     ';
    strSQL := strSQL + '         :SOLIMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      strCodFil := fAtualizaProCod('FILSEP', 'FIL_CODFIL');

      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('WHERE_').AsString := strWhere;
      ParamByName('TIPDOC').AsString := opcFila.ToString;
      ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
      ParamByName('NOMMAQ').AsString := cmbNomMaq.Text;
      ParamByName('SOLIMP').AsInteger := intSolImp;

      If (Not fEmptyStr(strCodLay)) Then
        ParamByName('CODLAY').AsString := strCodLay
      Else
        ParamByName('CODLAY').Clear;

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('FILSEP', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoSeparacao.fInsereFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoSeparacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtDescri) Then
  Begin
    If (fEmptyStr(edtDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A descrição deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtNomImp) And (edtNomImp.Enabled) Then
  Begin
    If (fEmptyStr(edtNomImp.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A fila de impressão deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodLay) And (edtCodLay.Visible) Then
  Begin
    If (fEmptyStr(edtCodLay.Text)) Then
    Begin
      edtDesLay.Clear;
      Exit;
    End;

    pCarregaDescricaoLayout;
    If (fEmptyStr(edtDesLay.Text)) Then
    Begin
      fMensagem('ATENÇÃO','Layout para impressão inválido!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = memWhere) Then
  Begin
    If (fEmptyStr(memWhere.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A condição where do sql deve deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgFilasImpressaoSeparacao.memWhereEnter(Sender: TObject);
begin
  inherited;
  memWhere.SelectAll;
end;

procedure TfrmCfgFilasImpressaoSeparacao.memWhereKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
  If (Key = #13) Then
  Begin
    If memWhere.SelText = memWhere.Text Then
    Begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCfgFilasImpressaoSeparacao.pCarregarNomeMaquinas;
Var
  LQuery: TUniQuery;
begin
  cmbNomMaq.Items.Clear;
  cmbNomMaq.Items.Add(EmptyStr);
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT DISTINCT ');
    LQuery.SQL.Add('  LOG_WTSMAQ AS NOMMAQ ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  LOGACE ');
    LQuery.SQL.Add('WHERE TRUE ');
    LQuery.SQL.Add('  AND LOG_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) ');
    LQuery.SQL.Add('  AND LOG_WTSMAQ <> "" ');
    LQuery.SQL.Add('ORDER BY NOMMAQ ');
    LQuery.Open;
    While Not LQuery.Eof Do
    Begin
      cmbNomMaq.Items.Add(LQuery.FieldByName('NOMMAQ').AsString);
      LQuery.Next;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TfrmCfgFilasImpressaoSeparacao.pHabilitarFilaImpressao;
begin
  If (ckbSolicitarImpressora.Checked) Then
  Begin
    edtNomImp.Clear;
    edtNomImp.Enabled := False;
  End
  Else
    edtNomImp.Enabled := True;
end;

function TfrmCfgFilasImpressaoSeparacao.fInformouFilaOuSelecaoDeImpressora : Boolean;
begin
  Result := True;

  If (Not fEmptyStr(edtNomImp.Text)) Then
    Exit;

  If (ckbSolicitarImpressora.Checked) Then
    Exit;

  Result := False;
end;

{ TOpcaoFilaHelper }

function TOpcaoFilaHelper.ToString: String;
begin
  Case Self Of
    ofPedido: Result := 'P';
    ofVenda : Result := 'V';
    ofOnda  : Result := 'O';
  End;
end;

end.
