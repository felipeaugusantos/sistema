unit untCadFaixaMargemTabPreco;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, untBaseListIntf, ExtCtrls, ComboBoxFocus, EditFocus, Grids,
  DBGridCitel, DBGrids, DB, UniClientDataSet, Uni,

  UniDataSetProvider, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFaixaMargemTabPreco = class(TfrmPai)
    pnlGrid: TPanel;
    Label12: TLabel;
    dbgCadTab: TDBGridCitel;
    pnlMargem: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtMarIni: TEditFocus;
    edtMarFin: TEditFocus;
    edtComPra: TEditFocus;
    btnConfirma: TBitBtnLocked;
    edtComVis: TEditFocus;
    Label1: TLabel;
    cmbTabPre: TComboBoxFocus;
    btnGravar: TBitBtnLocked;
    dtsCadTab: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pAfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cmbTabPreChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    blnAlterou,
    blnEditando: Boolean;
    cdsCadTab: TUniClientDataSet;
    dspCadTab: TUniDataSetProvider;

    function fGetTabPre: Integer;
    function fGetAutInc: Integer;

    procedure pCarregaTabelaPrecos;
    procedure pCarregaFaixasComissoes;

    procedure pAddItem;
    procedure pEditItem;
    procedure pDeleteItem;
    procedure pLimpaCampos;
    procedure pSetaMascaras;

    procedure pPreencheListaObjeto(objFaixaMargemTapPrecoList: IBaseList; cdsDataSet: TUniClientDataSet);
    function fCheckRange(fltFat: Double): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadFaixaMargemTabPreco: TfrmCadFaixaMargemTabPreco;

implementation

uses SysUtils, Forms, untFuncoesSimples,
   untFactoryClass, untCadComissaoFaixaDescTabPrecoIntf, untCadComissaoFaixaMargemTabPrecoDAO;

{$R *.dfm}

{ TfrmCadFaixaMargemTabPreco }

procedure TfrmCadFaixaMargemTabPreco.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
    pAddItem;
end;

procedure TfrmCadFaixaMargemTabPreco.btnGravarClick(Sender: TObject);
  Var
    objFaixaMargemTabPrecoList: IBaseList;
    cdsAux: TUniClientDataSet;
begin
  inherited;

  objFaixaMargemTabPrecoList := Factory.CreateList;
  cdsAux := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsAux, cdsCadTab);
  cdsAux.Filter   := '';
  cdsAux.Filtered := False;

  If fMensagem('ATENÇÃO', 'Confirma gravação das faixas de comissão?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pPreencheListaObjeto(objFaixaMargemTabPrecoList, cdsAux);

  If FaixaMargemTabPrecoDAO.fDeleteAll Then
  Begin
    If FaixaMargemTabPrecoDAO.fInsert(objFaixaMargemTabPrecoList) Then
    Begin
      fMensagem('ATENÇÃO', 'Faixas de comissões salvas com sucesso!!', ['&OK']);
      blnAlterou := False;
    End;
  End;

  objFaixaMargemTabPrecoList := nil;
end;

procedure TfrmCadFaixaMargemTabPreco.cmbTabPreChange(Sender: TObject);
begin
  cdsCadTab.Filter   := 'TABPRE = ' + QuotedStr(IntToStr(fGetTabPre));
  cdsCadTab.Filtered := True;
end;

procedure TfrmCadFaixaMargemTabPreco.pAfterPost(DataSet: TDataSet);
begin
  blnAlterou := True;
  btnGravar.Enabled := True;
  blnEditando := False;
  dbgCadTab.Enabled := True;
end;

function TfrmCadFaixaMargemTabPreco.fGetAutInc: Integer;
  Var
    cdsAux: TUniClientDataSet;
begin
  If blnEditando Then
  Begin
    Result := cdsCadTab.FieldByName('AUTINC').AsInteger;
    Exit;
  End;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsAux, cdsCadTab);

    cdsAux.IndexFieldNames := 'AUTINC';
    cdsAux.Last;
    
    Result := cdsAux.FieldByName('AUTINC').AsInteger + 1;
  Finally
    FreeAndNil(cdsAux);
  End;
end;

function TfrmCadFaixaMargemTabPreco.fGetTabPre: Integer;
begin
  Result := StrToInt(fRetSomenteNumeros(cmbTabPre.Text));
end;

procedure TfrmCadFaixaMargemTabPreco.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If blnAlterou And (fMensagem('', 'Deseja cancelar edição?', ['&Sim','&Não']) = 2) Then
    CanClose := False;
end;

procedure TfrmCadFaixaMargemTabPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) And blnEditando Then
  Begin
    Key := 0;
    blnEditando := False;
    pLimpaCampos;
    dbgCadTab.Enabled := True;
  End;

  If edtMarIni.Focused Then
  Begin
    If Key = VK_ESCAPE Then
      pSetFocus(cmbTabPre);
  End;

  If dbgCadTab.Focused Then
  Begin
    If (Key = VK_RETURN) And (Not cdsCadTab.IsEmpty) Then
    Begin
      pEditItem;
      pSetFocus(edtMarIni);
    End;

    If Key = VK_DELETE Then
      pDeleteItem;

    If Key = VK_ESCAPE Then
      pSetFocus(edtMarIni);
  End;
end;

procedure TfrmCadFaixaMargemTabPreco.FormShow(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
  pCarregaTabelaPrecos;
  pCarregaFaixasComissoes;
end;

procedure TfrmCadFaixaMargemTabPreco.pPreencheListaObjeto(objFaixaMargemTapPrecoList: IBaseList; cdsDataSet: TUniClientDataSet);
  Var
    objTemp: ICadComissaoFaixaDescTabPreco;
begin

  If Not cdsDataSet.IsEmpty Then
  Begin
    cdsDataSet.First;

    While Not cdsDataSet.Eof Do
    Begin
      objTemp           := Factory.Create('ComissaoFaixaTabPreco') as ICadComissaoFaixaDescTabPreco;
      objTemp.strTabPre := cdsDataSet.FieldByName('TABPRE').AsString;
      objTemp.fltDesIni := cdsDataSet.FieldByName('MARINI').AsFloat;
      objTemp.fltDesFin := cdsDataSet.FieldByName('MARFIN').AsFloat;
      objTemp.fltComVis := cdsDataSet.FieldByName('COMVIS').AsFloat;
      objTemp.fltComPra := cdsDataSet.FieldByName('COMPRA').AsFloat;
      objTemp.strCodEmp := VS_strCodEmp;
      objFaixaMargemTapPrecoList.Add(objTemp);

      cdsDataSet.Next;
    End;
  End;
end;

function TfrmCadFaixaMargemTabPreco.fCheckRange(fltFat: Double): Boolean;
  Var
    cdsAux: TUniClientDataSet;
begin
  Result := True;

  cdsAux := TUniClientDataSet.Create(Nil);

  Try
    pCloneDataSet(cdsAux, cdsCadTab);

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      If blnEditando And (cdsAux.FieldByName('AUTINC').AsInteger = fGetAutInc) Then
      Begin
        cdsAux.Next;
        Continue;
      End;

      If (cdsAux.FieldByName('TABPRE').AsInteger = fGetTabPre) Then
      Begin
        If (fltFat >= cdsAux.FieldByName('MARINI').AsFloat) And (fltFat <= cdsAux.FieldByName('MARFIN').AsFloat) Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      cdsAux.Next;
    End;
  Finally
    FreeAndNil(cdsAux);
  End;
end;

function TfrmCadFaixaMargemTabPreco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtMarIni Then
    Begin
      If Not fCheckRange(fStrToFloat(edtMarIni.Text)) Then
        strMsg := 'Desconto Inicial inválido! Já existe um intervalo contendo o valor especificado.'
    End

    Else If Sender = edtMarFin Then
    Begin
      If fStrToFloat(edtMarFin.Text) < fStrToFloat(edtMarIni.Text) Then
        strMsg := 'Desconto Final deve ser maior ou igual ao Desconto Inicial'

      Else If Not fCheckRange(fStrToFloat(edtMarFin.Text)) Then
        strMsg := 'Desconto Final inválido! Já existe um intervalo contendo o valor especificado.'
    End;

    If Not fEmptyStr(strMsg) Then
    Begin
      fMensagem('ATENÇÃO', strMsg, ['&O k']);
      Result := False;
      pSetFocus(Sender);
    End;
  End;
end;

procedure TfrmCadFaixaMargemTabPreco.pAddItem;
  Var
    intAutInc: Integer;
begin
  If Not cdsCadTab.Active Then
  Begin
    cdsCadTab.Open;
    pSetaClient(cdsCadTab);
  End;

  intAutInc := fGetAutInc;

  If blnEditando Then
    cdsCadTab.Edit
  Else
    cdsCadTab.Insert;

  cdsCadTab.FieldByName('AUTINC').AsInteger := intAutInc;
  cdsCadTab.FieldByName('TABPRE').AsInteger := fGetTabPre;
  cdsCadTab.FieldByName('MARINI').AsFloat   := fStrToFloat(edtMarIni.Text);
  cdsCadTab.FieldByName('MARFIN').AsFloat   := fStrToFloat(edtMarFin.Text);
  cdsCadTab.FieldByName('COMVIS').AsFloat   := fStrToFloat(edtComVis.Text);
  cdsCadTab.FieldByName('COMPRA').AsFloat   := fStrToFloat(edtComPra.Text);

  cdsCadTab.Post;

  cdsCadTab.IndexFieldNames := 'MARINI';
  
  pLimpaCampos;
  pSetFocus(cmbTabPre);
end;

procedure TfrmCadFaixaMargemTabPreco.pCarregaFaixasComissoes;
  Var
    qryCadTab: TUniQuery;
Begin
  qryCadTab := FaixaMargemTabPrecoDAO.fGetAll;

  Try
    dspCadTab := TUniDataSetProvider.Create(Nil);
    cdsCadTab := TUniClientDataSet.Create(Nil);

    dspCadTab.DataSet := qryCadTab;
    cdsCadTab.SetProvider(dspCadTab);
    cdsCadTab.Open;
    pSetaClient(cdsCadTab);
    pSetaMascaras;

    dtsCadTab.DataSet := cdsCadTab;

    qryCadTab.First;
    While (Not qryCadTab.Eof) Do
    Begin
      cdsCadTab.Edit;
      cdsCadTab.FieldByName('AUTINC').AsInteger := qryCadTab.RecNo;
      cdsCadTab.Post;

      qryCadTab.Next;
    End;

    cdsCadTab.AfterPost   := pAfterPost;
    cdsCadTab.AfterDelete := pAfterPost;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadFaixaMargemTabPreco.pCarregaFaixasComissoes]');
    End;
  End;

  cmbTabPre.ItemIndex := 0;

  cdsCadTab.Filter   := 'TABPRE = ' + QuotedStr(IntToStr(fGetTabPre));
  cdsCadTab.Filtered := True;
  cdsCadTab.First;
  
  FreeAndNil(qryCadTab);
end;

procedure TfrmCadFaixaMargemTabPreco.pCarregaTabelaPrecos;
  Var
    intCont: Integer;
begin
  cmbTabPre.Items.Clear;

  For intCont := 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    If (VS_strTabVen[intCont] = 'S') Then
      cmbTabPre.Items.Add('Tabela de Preço ' + IntToStr(intCont));
  End;
end;

procedure TfrmCadFaixaMargemTabPreco.pDeleteItem;
begin
  If Not cdsCadTab.IsEmpty Then
    If fMensagem('', 'Deseja apagar registro selecionado?', ['&Sim', '&Não']) = 1 Then
      cdsCadTab.Delete;
end;

procedure TfrmCadFaixaMargemTabPreco.pEditItem;
begin
  If Not cdsCadTab.IsEmpty Then
  Begin
    blnEditando := True;
    dbgCadTab.Enabled := False;

    edtMarIni.Text := FormatFloat('#,##0.00', cdsCadTab.FieldByName('MARINI').AsFloat);
    edtMarFin.Text := FormatFloat('#,##0.00', cdsCadTab.FieldByName('MARFIN').AsFloat);
    edtComPra.Text := FormatFloat('#,##0.00', cdsCadTab.FieldByName('COMPRA').AsFloat);
    edtComVis.Text := FormatFloat('#,##0.00', cdsCadTab.FieldByName('COMVIS').AsFloat);

    pSetFocus(edtMarIni);
  End;
end;

procedure TfrmCadFaixaMargemTabPreco.pLimpaCampos;
begin
  edtMarIni.Text := '0,00';
  edtMarFin.Text := '0,00';
  edtComPra.Text := '0,00';
  edtComVis.Text := '0,00';
  pSetFocus(edtMarIni);
end;

procedure TfrmCadFaixaMargemTabPreco.pSetaMascaras;
begin
  If cdsCadTab.FindField('MARINI') <> Nil Then
    TFloatField(cdsCadTab.FieldByName('MARINI')).DisplayFormat := '#,##0.00';

  If cdsCadTab.FindField('MARFIN') <> Nil Then
    TFloatField(cdsCadTab.FieldByName('MARFIN')).DisplayFormat := '#,##0.00';

  If cdsCadTab.FindField('COMVIS') <> Nil Then
    TFloatField(cdsCadTab.FieldByName('COMVIS')).DisplayFormat := '#,##0.00';

  If cdsCadTab.FindField('COMPRA') <> Nil Then
    TFloatField(cdsCadTab.FieldByName('COMPRA')).DisplayFormat := '#,##0.00';
end;

end.
