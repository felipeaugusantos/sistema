unit untFatItensRepresent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, Uni, DB, untFuncFat, AppEvnts, untFatItensRepr,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatItensRepresent = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgItens: TDBGridCitel;
    Panel1: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label26: TLabel;
    edtUnidad: TEditFocus;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    edtUnitar: TEditFocus;
    Label12: TLabel;
    Label15: TLabel;
    edtTotIte: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    Label32: TLabel;
    edtTotGer: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryCadIte: TUniQuery;
    qryIteGer: TUniQuery;
    procedure pCarregaItens(blnAtuPrecos: Boolean);
    procedure pCalculaTotIte;
    procedure pCalculaTotais;
    procedure pLimparCampos;
    procedure pHabilitaCab(blnHabilitar: Boolean);
    procedure pAtualizaCampos(DataSet: TDataSet);
  protected
    repItens: TFatItensRepresent;
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    fatVenda: TFatVenda;
  end;

var
  frmFatItensRepresent: TfrmFatItensRepresent;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatItensRepresent.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryCadIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatItensRepresent.FormShow(Sender: TObject);
begin
  inherited;
  qryCadIte := fCriaQuery;
  qryIteGer := fCriaQuery;

  If (Not Assigned(fatVenda.repItens)) Then
  Begin
    repItens  := TFatItensRepresent.Create(fatVenda, strNumDoc, strEspDoc, VS_strCodEmp);
  End
  Else
  Begin
    repItens := fatVenda.repItens;
  End;

  repItens.cdsCdsTmp.AfterScroll := pAtualizaCampos;
  dbgItens.DataSource := repItens.dtsDtsTmp;

  fatVenda.repItens := repItens;
  pCalculaTotais;
  psetfocus(edtCodIte);
end;

function TfrmFatItensRepresent.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodIte) Then
  Begin

    If (fEmptyStr(edtCodIte.Text)) Then
    Begin
      pSetFocus(dbgItens);
      blnMudarFoco := False;
    End
    Else
    Begin
      pCarregaItens(blnBuscaPorChave);
      If (qryCadIte.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtDesIte) Then
  Begin
  End

  Else If (Sender = edtUnidad) Then
  Begin
    If (Not fEmptyStr(edtCodIte.Text)) Then
    Begin

      If (fEmptyStr(edtUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fEmptyStr(fRetNomUnidade(edtUnidad.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&Ok']);
        Result := False;
      End;

    End;
  End

  Else If (Sender = edtQtdIte) Then
  Begin

    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser digitada!', ['&Ok']);
      Result := False;
    End
    Else if (fStrToFloat(edtQtdIte.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else
      pCalculaTotIte;

  End

  Else If (Sender = edtUnitar) Then
  Begin
    If (fEmptyStr(edtUnitar.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O unitário deve ser digitado!', ['&Ok']);
      Result := False;
    End
    Else if (fStrToFloat(edtUnitar.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O unitário deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else
      pCalculaTotIte;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatItensRepresent.pCalculaTotais;
  Var
    fltTotIte: Double;
begin

  If TAggregateField(repItens.cdsCdsTmp.FieldByName('TOT_TOTITE')).Value = Null Then
    fltTotIte := 0
  Else
    fltTotIte := TAggregateField(repItens.cdsCdsTmp.FieldByName('TOT_TOTITE')).Value;

  edtTotGer.Text := FloatToStrF(fltTotIte, ffFixed, 12, 2);
  btnConfirma.Enabled := (fltTotIte > 0.0);

end;

procedure TfrmFatItensRepresent.pCalculaTotIte;
begin

  If (fEmptyStr(edtQtdIte.Text)) Then
    edtQtdIte.Text := '0,00';

  If (fEmptyStr(edtUnitar.Text)) Then
    edtUnitar.Text := '0,0000';

  edtTotIte.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text), ffFixed, 12, 2);

end;

procedure TfrmFatItensRepresent.pCarregaItens(blnAtuPrecos: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := edtCodIte.Text;
    Open;
  End;

  If (blnAtuPrecos) Then
  Begin
    edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
    edtUnidad.Text := qryCadIte.FieldByName('ITE_CODUNI').AsString;
  End;

  If (Not qryCadIte.IsEmpty) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryIteGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If (blnAtuPrecos) Then
    Begin
      edtUnitar.Text := FloatToStrF(qryIteGer.FieldByName('ITE_PREVE1').AsFloat, ffFixed, 12, 4);
      edtQtdIte.Text := '0,00';
    End;

    If (Pos('ITEM ESPECIAL', qryCadIte.FieldByName('ITE_DESITE').AsString) > 0) Then
    Begin
      edtDesIte.Enabled := True;
      edtUnidad.Enabled := True;
    End
    Else
    Begin
      edtDesIte.Enabled := False;
      edtUnidad.Enabled := False;
    End;

  End
  Else
    qryIteGer.Close;

end;

procedure TfrmFatItensRepresent.pEscapePressed;
begin
  inherited;

end;

procedure TfrmFatItensRepresent.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin

    If (btnAdicionar.Tag = 0) Then
    Begin
      repItens.pAdicionaItemTmp(edtCodIte.Text,
                                edtDesIte.Text,
                                qryCadIte.FieldByName('ITE_DESITE').AsString,
                                qryCadIte.FieldByName('ITE_REFERE').AsString,
                                edtUnidad.Text,
                                fStrToFloat(edtQtdIte.Text),
                                fStrToFloat(edtUnitar.Text),
                                fStrToFloat(edtTotIte.Text));
    End
    Else
    Begin
      repItens.pEditaItemTmp(edtDesIte.Text,
                             edtUnidad.Text, 
                             fStrToFloat(edtQtdIte.Text),
                             fStrToFloat(edtUnitar.Text),
                             fStrToFloat(edtTotIte.Text));
    End;
    pCalculaTotais;
    btnCancelaItem.Click;
    btnAdicionar.Tag := 0;
  End;

end;

procedure TfrmFatItensRepresent.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pHabilitaCab(True);
  pSetFocus(edtCodIte);
end;

procedure TfrmFatItensRepresent.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pHabilitaCab(False);
  pAtualizaCampos(Nil);
end;

procedure TfrmFatItensRepresent.pLimparCampos;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtUnidad.Clear;
  edtQtdIte.Clear;
  edtUnitar.Clear;
  edtTotIte.Clear;
end;

procedure TfrmFatItensRepresent.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    edtQtdIte.Enabled := True;
    edtUnitar.Enabled := True;
    pSetFocus(edtQtdIte);
    If (Pos('ITEM ESPECIAL', repItens.cdsCdsTmp.FieldByName('ITE_DESORI').AsString) > 0) Then
    Begin
      edtDesIte.Enabled := True;
      edtUnidad.Enabled := True;
      pSetFocus(edtDesIte);
    End;
    btnAdicionar.Tag := 99;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnCancelaItem.Click;
    pHabilitaCab(True);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If Not repItens.cdsCdsTmp.IsEmpty then
    Begin
      repItens.cdsCdsTmp.Delete;
      pCalculaTotais;
    End;
  End;
end;

procedure TfrmFatItensRepresent.pHabilitaCab(blnHabilitar: Boolean);
begin
  edtCodIte.Enabled := blnHabilitar;
  edtDesIte.Enabled := blnHabilitar;
  edtUnidad.Enabled := blnHabilitar;
  edtQtdIte.Enabled := blnHabilitar;
  edtUnitar.Enabled := blnHabilitar;
end;

procedure TfrmFatItensRepresent.pAtualizaCampos(DataSet: TDataSet);
begin

  edtCodIte.Text := repItens.cdsCdsTmp.FieldByName('ITE_CODITE').AsString;
  edtDesIte.Text := repItens.cdsCdsTmp.FieldByName('ITE_DESITE').AsString;
  edtUnidad.Text := repItens.cdsCdsTmp.FieldByName('ITE_UNIDAD').AsString;
  edtUnitar.Text := FloatToStrF(repItens.cdsCdsTmp.FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, 4);
  edtQtdIte.Text := FloatToStrF(repItens.cdsCdsTmp.FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, 2);
  edtTotIte.Text := FloatToStrF(repItens.cdsCdsTmp.FieldByName('ITE_TOTITE').AsFloat, ffFixed, 12, 2);

end;

procedure TfrmFatItensRepresent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult = mrOk) And (repItens.cdsCdsTmp.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário digitar pelo menos 1 item!', ['&Ok']);
    Action := caNone;
  End;

  repItens.cdsCdsTmp.AfterScroll := Nil;

  If ModalResult <> mrOk Then
  Begin
    If repItens.cdsCdsTmp.ChangeCount > 0 then
      repItens.cdsCdsTmp.CancelUpdates;
  End;

  inherited;
end;

procedure TfrmFatItensRepresent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
    Key := 0;
  End;
end;

end.


