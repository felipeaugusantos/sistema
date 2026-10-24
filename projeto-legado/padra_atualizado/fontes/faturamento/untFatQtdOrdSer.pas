{*********************************************************}
{* DIGITAÇÃO DE ITENS DE ORDEM DE PRODUÇÃO               *}
{*                                                       *}
{* DATA......: 01/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untFatQtdOrdSer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  EditFocus, QColorLabel, Uni, DB, untFatOrdSer, AppEvnts, frxClass,
  frxExportCSVTestabilidade, BitBtnLockedIncrem, DBGridCitel;

type
  TfrmFatQtdOrdSer = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    pnlTopo: TPanel;
    pnlItens: TPanel;
    dbgItens: TDBGridCitel;
    edtItem: TEditFocus;
    Label1: TLabel;
    edtRefere: TEditFocus;
    Label2: TLabel;
    edtUnidad: TEditFocus;
    Label3: TLabel;
    edtQuant: TEditFocus;
    Label4: TLabel;
    edtLargura: TEditFocus;
    Label5: TLabel;
    edtAltura: TEditFocus;
    Label6: TLabel;
    edtTotM2: TEditFocus;
    Label7: TLabel;
    edtObserv: TEditFocus;
    Label8: TLabel;
    edtTarja: TEditFocus;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    edtRecLoc: TEditFocus;
    Label10: TLabel;
    ColorLabel2: TColorLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    pnlBaixo: TPanel;
    Label11: TLabel;
    edtTotGerM2: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pFocaGrid;
    procedure pLimpaCampos;
    procedure pEditaDados;
    procedure pAtualizaDados;
    procedure pDeletaRegistro;
    procedure pCalculaTotM2;

    function fTotalizaM2(strQtdSer, strLargura, strAltura: String): String;
  public
    { Public declarations }
    intSeqInd: Integer;
    blnTrava : Boolean;
    strNumOrc: String;
    strEspOrc: String;
    strEmpOrc: String;
    strCodIte: String;
    strCodGru: String;

    objOrdSer: TOrdSer;

    FEditar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

var
  frmFatQtdOrdSer: TfrmFatQtdOrdSer;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmFatQtdOrdSer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnGravar.Click;
  End;

end;

function TfrmFatQtdOrdSer.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {**************************************}
  {* VALIDA QUANTIDADE                  *}
  {***********************************AF*}
  If (Sender = edtQuant) Then
  Begin

    If fEmptyStr(edtQuant.Text) And (Not blnBuscaPorChave) Then
    Begin

      fMensagem('','A quantidade deve ser preenchida!',['&OK']);
      Result := False;

    End
    Else If ((StrToIntDef(edtQuant.Text,0) = 0) Or fEmptyStr(edtQuant.Text)) And blnBuscaPorChave Then
    Begin

      pFocaGrid;
      blnMudarFoco := False;

    End
    Else
    Begin

      If StrToIntDef(edtQuant.Text,0) < 0 Then
      Begin
        fMensagem('','A quantidade deve ser maior que zero!', ['&OK']);
        Result := False;
      End;

    End;

  End

  {**************************************}
  {* VALIDA LARGURA                     *}
  {***********************************AF*}
  Else If (Sender = edtLargura) Then
  Begin

    If fEmptyStr(edtLargura.Text) Then
    Begin
      fMensagem('','A largura deve ser preenchida!',['&OK']);
      Result := False;
    End

    Else If fStrToFloat(edtLargura.Text) <= 0 Then
    Begin
      fMensagem('','A largura deve ser maior que zero!',['&OK']);
      Result := False;
    End

    Else
      edtTotM2.Text := fTotalizaM2(edtQuant.Text, edtLargura.Text, edtAltura.Text);

  End

  {**************************************}
  {* VALIDA ALTURA                      *}
  {***********************************AF*}
  Else If (Sender = edtAltura) Then
  Begin

    If fEmptyStr(edtAltura.Text) Then
    Begin
      fMensagem('','A altura deve ser preenchida!',['&OK']);
      Result := False;
    End

    Else If fStrToFloat(edtAltura.Text) <= 0 Then
    Begin
      fMensagem('','A altura deve ser maior que zero!',['&OK']);
      Result := False;
    End;

  End

  {**************************************}
  {* VALIDA TARJA                       *}
  {***********************************AF*}
  Else If (Sender = edtTarja) Then
  Begin

    If fEmptyStr(edtTarja.Text) Then
    Begin
      fMensagem('','A tarja deve ser preenchida!',['&OK']);
      Result := False;
    End

    Else If Pos(edtTarja.Text,'SN') <= 0 Then
    Begin
      fMensagem('','A tarja deve ser S ou N!',['&OK']);
      Result := False;
    End;

  End

  {**************************************}
  {* VALIDA CAMPO RECLOC                *}
  {***********************************AF*}
  Else If (Sender = edtRecLoc) Then
  Begin

    If fEmptyStr(edtRecLoc.Text) Then
    Begin
      fMensagem('','O campo recorte no local deve ser preenchido!',['&OK']);
      Result := False;
    End

    Else If Pos(edtRecLoc.Text,'SN') <= 0 Then
    Begin
      fMensagem('','O campo recorte no local deve ser S ou N!',['&OK']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

{**************************************}
{* FOCA GRID PARA SELECIONAR DADOS A  *}
{* ALTERAR                            *}
{***********************************AF*}
procedure TfrmFatQtdOrdSer.pFocaGrid;
Begin
  dbgItens.Enabled := True;
  pSetFocus(dbgItens);
  pnlItens.Enabled := False;
  pLimpaCampos;
End;

{**************************************}
{* EDITA DADOS APOS SELECIONAR O ITEM *}
{* NO GRID                            *}
{***********************************AF*}
procedure TfrmFatQtdOrdSer.pEditaDados;
Begin

  If (Assigned(qryTabela)) Then Begin
    With qryTabela Do
    Begin
      edtQuant.Text    := FieldByName('ORD_QTDSER').AsString;
      edtLargura.Text  := FloatToStrF(FieldByName('ORD_LARGUR').AsFloat,ffFixed,12,2);
      edtAltura.Text   := FloatToStrF(FieldByName('ORD_ALTURA').AsFloat,ffFixed,12,2);
      edtTotM2.Text    := FloatToStrF(FieldByName('ORD_TOT_M2').AsFloat,ffFixed,12,2);
      edtTarja.Text    := FieldByName('ORD_TARJA_').AsString;
      edtRecLoc.Text   := FieldByName('ORD_RECLOC').AsString;
      edtObserv.Text   := FieldByName('ORD_OBSERV').AsString;
      dbgItens.Enabled := False;
      btnAdicionar.Tag := FieldByName('ORD_AUTINC').AsInteger;
      pnlItens.Enabled := True;
      pSetFocus(edtQuant);
    End;
  End;

End;

{**************************************}
{* RECARREGA OS DADOS DA TEMPORARIA   *}
{***********************************AF*}
procedure TfrmFatQtdOrdSer.pAtualizaDados;
Begin

  objOrdSer.pAtualizaDados(strNumOrc, strEspOrc, strEmpOrc, strCodIte, intSeqInd, False);
  pCalculaTotM2;

End;

{**************************************}
{* CALCULA O TOTAL DA COLUNA TOT_M2   *}
{* DE TODOS OS ITENS                  *}
{***********************************AF*}
procedure TfrmFatQtdOrdSer.pCalculaTotM2;
  Var
    fltTotM2: Double;
Begin
  fltTotM2 := 0;

  objOrdSer.cdsOrdSer.First();


  While (Not objOrdSer.cdsOrdSer.Eof) Do Begin
    If (objOrdSer.cdsOrdSer.FieldByName('ORD_CODEMP').AsString = strEmpOrc) And
       (objOrdSer.cdsOrdSer.FieldByName('ORD_CODITE').AsString = strCodIte) And
       (objOrdSer.cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger = intSeqInd) Then Begin
      fltTotM2 := fltTotM2 + objOrdSer.cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat;
    End;

    objOrdSer.cdsOrdSer.Next();
  End;

  edtTotGerM2.Text := FloatToStrF(fltTotM2, ffFixed, 12, 2);
End;

{**************************************}
{* NAUM PRECISO DIZER NADA NÉ...      *}
{***********************************AF*}
procedure TfrmFatQtdOrdSer.pLimpaCampos;
Begin
  edtQuant.Clear;
  edtLargura.Clear;
  edtAltura.Clear;
  edtTotM2.Clear;
  edtTarja.Clear;
  edtRecLoc.Clear;
  edtObserv.Clear;

  edtQuant.Text   := '0';
  edtLargura.Text := '0,00';
  edtAltura.Text  := '0,00';
End;

procedure TfrmFatQtdOrdSer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  objOrdSer.cdsOrdSer.Filtered := False;
end;

procedure TfrmFatQtdOrdSer.FormCreate(Sender: TObject);
begin
  inherited;

  objOrdSer := Nil;
end;

procedure TfrmFatQtdOrdSer.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin

    If btnAdicionar.Tag = 0 Then Begin
      objOrdSer.cdsOrdSer.Append();
    End Else Begin
      If (objOrdSer.cdsOrdSer.Locate('ORD_AUTINC', 'IntToStr(btnAdicionar.Tag)', [])) Then Begin
        objOrdSer.cdsOrdSer.Edit();
        btnAdicionar.Tag := 0;
        dbgItens.Enabled := True;
      End;
    End;

    objOrdSer.cdsOrdSer.FieldByName('ORD_CODITE').AsString  := strCodIte;
    objOrdSer.cdsOrdSer.FieldByName('ORD_QTDSER').AsInteger := StrToInt(edtQuant.Text);
    objOrdSer.cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat   := fStrToFloat(edtLargura.Text);
    objOrdSer.cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat   := fStrToFloat(edtAltura.Text);
    objOrdSer.cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat   := fStrToFloat(edtTotM2.Text);
    objOrdSer.cdsOrdSer.FieldByName('ORD_TARJA_').AsString  := edtTarja.Text;
    objOrdSer.cdsOrdSer.FieldByName('ORD_RECLOC').AsString  := edtRecLoc.Text;
    objOrdSer.cdsOrdSer.FieldByName('ORD_OBSERV').AsString  := edtObserv.Text;
    objOrdSer.cdsOrdSer.FieldByName('ORD_NUMDOC').AsString  := strNumOrc;
    objOrdSer.cdsOrdSer.FieldByName('ORD_ESPDOC').AsString  := strEspOrc;
    objOrdSer.cdsOrdSer.FieldByName('ORD_CODEMP').AsString  := strEmpOrc;
    objOrdSer.cdsOrdSer.FieldByName('ORD_CODCLI').AsString  := objOrdSer.strCodCli;
    objOrdSer.cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger := intSeqInd;
    objOrdSer.cdsOrdSer.FieldByName('MARDES').AsString      := 'D';
    objOrdSer.cdsOrdSer.FieldByName('ORD_ITEDEL').AsString  := 'N';
    objOrdSer.cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger := 1;

    objOrdSer.cdsOrdSer.Post();

    pAtualizaDados;
    pLimpaCampos;
    pSetFocus(edtQuant);
  End;
end;

procedure TfrmFatQtdOrdSer.pEscapePressed;
begin

  If ActiveControl Is TDBGridCitel Then
  Begin
    btnAdicionar.Tag := 0;
    pnlItens.Enabled := True;
    pSetFocus(edtQuant);
  End
  Else
    inherited;

end;

{**************************************}
{* CALCULA VALOR DE TOT_M2            *}
{***********************************AF*}
function TfrmFatQtdOrdSer.fTotalizaM2(strQtdSer, strLargura, strAltura: String): String;
Begin

  Result := FloatToStrF(0,ffFixed,12,2);

  If fEmptyStr(strQtdSer) Or fEmptyStr(strLargura) Or fEmptyStr(strAltura) Then
    Exit;

  Result := FloatToStrF(fStrToFloat(strQtdSer) * fStrToFloat(strLargura) * fStrToFloat(strAltura),ffFixed,12,2);

End;

procedure TfrmFatQtdOrdSer.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pLimpaCampos;
  pSetFocus(edtQuant);

end;

procedure TfrmFatQtdOrdSer.btnGravarClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatQtdOrdSer.FormShow(Sender: TObject);
  Var
    strDescri: String;
    strRefere: String;
    strMarca : String;
    strUnidad: String;
begin
  inherited;

  If (Not Assigned(objOrdSer)) Then
    objOrdSer := TOrdSer.Create;

  dbgItens.DataSource := objOrdSer.dtsOrdSer;

  objOrdSer.pAtualizaDados(strNumOrc, strEspOrc, strEmpOrc, strCodIte, intSeqInd, False);

  If blnTrava Then
    pnlItens.Enabled := False;

  pRetDadosItem(strCodIte, strCodGru, strDescri, strRefere, strMarca, strUnidad);

  edtItem.Text   := strCodIte + '-' + strDescri;
  edtRefere.Text := strRefere;
  edtUnidad.Text := strUnidad;

  If FEditar Then
  Begin
    If objOrdSer.cdsOrdSer.RecordCount = 0 Then
    Begin
      objOrdSer.cdsOrdSer.EmptyDataSet;
      objOrdSer.pAtualizaDados(strNumOrc, strEspOrc, strEmpOrc, '', 0, True);
    End;

    objOrdSer.cdsOrdSer.Filtered := False;
    objOrdSer.cdsOrdSer.Filter   := 'ORD_CODITE = ' + QuotedStr(strCodIte);
    objOrdSer.cdsOrdSer.Filtered := True;

    objOrdSer.cdsOrdSer.Open;

    If intSeqInd <= 0 Then
      intSeqInd := objOrdSer.fGetSeqIndProduto(strCodIte);
  End
  Else
    pAtualizaDados;

  pLimpaCampos;
  pCalculaTotM2;

  pSetFocus(edtQuant);
end;

procedure TfrmFatQtdOrdSer.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return)  And (Not blnTrava) Then
    pEditaDados

  Else If (Key = VK_Escape) Then
  Begin

    If (Not blnTrava) Then
    Begin
      pLimpaCampos;
      dbgItens.Enabled := False;
      btnAdicionar.Tag := 0;
      pnlItens.Enabled := True;
      pSetFocus(edtQuant);
    End
    Else
      btnSair.Click;
      
  End

  Else If (Key = VK_Delete) Then
  Begin

    If Not blnTrava Then
    Begin
      pDeletaRegistro;
    End;

  End;

end;

procedure TfrmFatQtdOrdSer.pDeletaRegistro;
Begin

  If Not objOrdSer.cdsOrdSer.IsEmpty Then
  Begin
    objOrdSer.cdsOrdSer.Delete();

    pAtualizaDados;
  End;

End;

end.

