unit untConsultaCds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, UniClientDataSet, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, BitBtnLockedIncrem, Datasnap.DBClient;

type
  TfrmConsultaCds = class(TForm)
    dbgConsulta: TDBGridCitel;
    pnlBotoes: TPanel;
    Label2: TLabel;
    stbStatus: TStatusBar;
    Panel1: TPanel;
    Label1: TLabel;
    lblBuscarPor1: TLabel;
    lblChave1: TLabel;
    lblChave2: TLabel;
    lblBuscarPor2: TLabel;
    lblBuscarPor3: TLabel;
    lblChave3: TLabel;
    lstIndices: TListBox;
    edtFiltro1: TEdit;
    edtFiltro2: TEdit;
    edtFiltro3: TEdit;
    Relogio: TTimer;
    dtsConsulta: TDataSource;
    cdsConsulta: TUniClientDataSet;
    btnConfirma: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lstIndicesClick(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
  private
    function fRetornaCampoFiltro(intIndice, intChave: Integer): String;
    function fContaCampos(strCampos: String): Integer;
    procedure pAplicaFiltro;
    { Private declarations }
  protected
    procedure pAtuIndice(intIndice: Integer); virtual;
    procedure pAfterScroll(DataSet: TDataSet); virtual;

    function fMontaFiltro: String;
  public
    { Public declarations }
    stlCampos: TStringList;
    stlIndices: TStringList;

    strUltSelect   : String;
    bkmUltAcesso   : TBookmark;
    strUltIndice1  : String;
    strUltIndice2  : String;
    strUltIndice3  : String;
    intUltItemIndex: Integer;
    bkmResult      : TBookmark;
  end;

var
  frmConsultaCds: TfrmConsultaCds;

implementation

uses untFuncoesSimples, StrUtils;

{$R *.dfm}

{ TfrmConsultaCds }

procedure TfrmConsultaCds.pAtuIndice(intIndice: Integer);
  Var
    intQtdCampos: Integer;
    intPos: Integer;
    intPosAnt: Integer;

    intContador: Integer;
    strCampo: String;

    procedure pDefineLabel(lblLabel: TLabel);
    begin
      If (lblLabel.Visible) Then
      Begin
        intPos := PosEx('+', stlIndices[intIndice], intPosAnt);
        If intPos > 0 Then
          lblLabel.Caption := Copy(stlIndices[intIndice], intPosAnt, intPos-intPosAnt)
        Else
          lblLabel.Caption := Copy(stlIndices[intIndice], intPosAnt, Length(stlIndices[intIndice]));

        lblLabel.Caption := cdsConsulta.FieldByName(lblLabel.Caption).DisplayLabel;
      End;

      intPosAnt := intPos+1;
    end;

begin

  intQtdCampos := fContaCampos(stlIndices[intIndice]);
  intPOs := 1;
  intPosAnt := 1;
  strCampo := '';

  lblBuscarPor1.Visible := (intQtdCampos >= 1);
  lblChave1.Visible     := (intQtdCampos >= 1);
  edtFiltro1.Visible    := (intQtdCampos >= 1);

  lblBuscarPor2.Visible := (intQtdCampos >= 2);
  lblChave2.Visible     := (intQtdCampos >= 2);
  edtFiltro2.Visible    := (intQtdCampos >= 2);

  lblBuscarPor3.Visible := (intQtdCampos >= 3);
  lblChave3.Visible     := (intQtdCampos >= 3);
  edtFiltro3.Visible    := (intQtdCampos >= 3);

  pDefineLabel(lblChave1);
  pDefineLabel(lblChave2);
  pDefineLabel(lblChave3);

  cdsConsulta.IndexFieldNames := '';
  For intContador := 1 To 3 Do
  Begin
    strCampo := fRetornaCampoFiltro(intIndice, intContador);

    If Not fEmptyStr(strCampo) Then
    Begin

      If Not fEmptyStr(cdsConsulta.IndexFieldNames) Then
        cdsConsulta.IndexFieldNames := cdsConsulta.IndexFieldNames + ';';

      cdsConsulta.IndexFieldNames := cdsConsulta.IndexFieldNames + strCampo;

    End;
    
  End;

  pAplicaFiltro;

end;

procedure TfrmConsultaCds.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    intChave: Integer;
    strCampo: String;
    strDesInd: String;
begin

  dtsConsulta.DataSet := cdsConsulta;
  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;

  {*****************************************}
  {* MOSTRA APENAS OS CAMPOS ESCOLHIDOS    *}
  {**************************************MV*}
  For intContador := 0 To cdsConsulta.FieldCount -1 Do
  Begin
    If stlCampos.IndexOf(cdsConsulta.Fields[intContador].FieldName) >= 0 Then
      cdsConsulta.Fields[intContador].Visible := True
    Else
      cdsConsulta.Fields[intContador].Visible := False;
  End;

  For intContador := 0 To stlIndices.Count -1 Do
  Begin

    strDesInd := '';
    For intChave := 1 To 3 Do
    Begin

      strCampo := fRetornaCampoFiltro(intContador, intChave);
      If (Not fEmptyStr(strCampo)) Then
      Begin

        If intChave > 1 Then
          strDesInd := strDesInd + '/';

        strDesInd := strDesInd + cdsConsulta.FieldByName(strCampo).DisplayLabel;

      End;

    End;

    lstIndices.Items.Add(strDesInd);

  End;

  lstIndices.ItemIndex := intUltItemIndex;
  edtFiltro1.Text      := strUltIndice1;
  edtFiltro2.Text      := strUltIndice2;
  edtFiltro3.Text      := strUltIndice3;

  pAtuIndice(lstIndices.ItemIndex);

  If Assigned(bkmUltAcesso) Then
    Try
      cdsConsulta.GotoBookmark(bkmUltAcesso);
    Except
      // Apenas para não dar erro
      Try
        cdsConsulta.RecNo := StrToIntDef(strUltSelect, 1);
      Except
        // Apenas para não dar erro
      End;
    End;
  pSetFocus(btnConfirma);

end;

{function TfrmConsultaCds.fRetornaCampoFiltro(intIndice, intChave: Integer): String;
  Var
    intContador: Integer;
    intPos1: Integer;
    intPos2: Integer;
begin
  Result      := '';
  intPos1     := 0;
  intContador := 1;

  While intContador <= intChave Do
  Begin
    intPos1 := PosEx('+', stlIndices[intIndice-1], intContador);
    Inc(intContador);
  End;

  If intPos1 <= 0 Then
    Result := stlIndices[intIndice]
  Else
  Begin
    intPos2 := PosEx('+', stlIndices[intIndice-1], intPos1+1);
    If intPos2 <= 0 Then
      Result := Copy(stlIndices[intIndice-1], intPos1, Length(stlIndices[intIndice]))
    Else
      Result := Copy(stlIndices[intIndice-1], intPos1+1, intPos2-intPos1-1);
  End;
end;}

function TfrmConsultaCds.fRetornaCampoFiltro(intIndice, intChave: Integer): String;
  Var
    intContador: Integer;
    intChaveAtu: Integer;
    strIndice: String;
begin

  strIndice   := stlIndices[intIndice];
  intChaveAtu := 1;
  intContador := 1;
  Result      := '';
  While (intContador <= Length(strIndice)) And
        (intChaveAtu <= intChave)        Do
  Begin

    If intChaveAtu = intChave Then
    Begin
      If strIndice[intContador] <> '+' Then
      Begin
        Result := Result + strIndice[intContador];
      End;
    End;

    If strIndice[intContador] = '+' Then
    Begin
      Inc(intChaveAtu);
    End;

    Inc(intContador);
  End;

end;

function TfrmConsultaCds.fMontaFiltro: String;
  Var
    strCampo: String;
    strOperador: String;

  function fCampoFiltro(intIndice, intChave: Integer): String;
  begin
    Result   := fRetornaCampoFiltro(intIndice, intChave);
    strCampo := Result;
  end;

  function fOperador(intIndice: Integer): String;
    Var
      fldCampo: TField;
  begin
    Result   := '';
    fldCampo := cdsConsulta.FieldByName(strCampo);

    If fldCampo.DataType in [ftString] Then
      Result := ' LIKE '
    Else
      Result := ' = ';

    strOperador := Result;
  end;

  function fValor(intIndice: Integer): String;
    Var
      fldCampo: TField;
  begin
    Result := '';
    Case intIndice Of
      1: Result := edtFiltro1.Text;
      2: Result := edtFiltro2.Text;
      3: Result := edtFiltro3.Text;
    End;

    If Pos('LIKE', strOperador) > 0 Then
    Begin
      Result := QuotedStr(Result + '%');
    End
    Else
    Begin
      fldCampo := cdsConsulta.FieldByName(strCampo);
      If fldCampo.DataType in [ftFLoat] Then
        Result := AnsiReplaceStr(Result, ',', '.');
    End;

  end;

begin

  Result   := '';
  If (edtFiltro1.Visible) And (Not fEmptyStr(edtFiltro1.Text)) Then
  Begin
    Result   := fCampoFiltro(lstIndices.ItemIndex, 1) + fOperador(1) + fValor(1);
  End;

  If (edtFiltro2.Visible) And (Not fEmptyStr(edtFiltro2.Text)) Then
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' AND ';

    Result := Result + fCampoFiltro(lstIndices.ItemIndex, 2) + fOperador(2) + fValor(2);
  End;

  If (edtFiltro3.Visible) And (Not fEmptyStr(edtFiltro3.Text)) Then
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + ' AND ';

    Result := Result + fCampoFiltro(lstIndices.ItemIndex, 3) + fOperador(3) + fValor(3);
  End;

end;

procedure TfrmConsultaCds.edtFiltro1Change(Sender: TObject);
begin
  pAplicaFiltro;
end;

function TfrmConsultaCds.fContaCampos(strCampos: String): Integer;
  Var
    strTmpCampos: String;
begin
  strTmpCampos := strCampos;

  Result := 0;
  If Trim(strTmpCampos) <> '' Then
  Begin
    If Pos('+', strTmpCampos) = 0 Then
      Result := 1
    Else
    Begin
      Result := 2;
      Delete(strTmpCampos, 1, Pos('+', strTmpCampos));
      If Pos('+', strTmpCampos) > 0 Then
        Result := 3;
    End;
  End;
end;

procedure TfrmConsultaCds.pAplicaFiltro;
begin
  cdsConsulta.Filter := fMontaFiltro;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filtered := True;
end;

procedure TfrmConsultaCds.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    blnGridFocado: Boolean;
begin
  blnGridFocado := dbgConsulta.Focused;
	If Key = VK_F3 Then
  Begin
    If lstIndices.ItemIndex = lstIndices.Items.Count -1 Then
    	lstIndices.Selected[0] := True
    Else
    Begin
      If lstIndices.ItemIndex < lstIndices.Items.Count -1 Then
        lstIndices.Selected[lstIndices.ItemIndex + 1] := True;
    End;

    edtFiltro1.Clear;
    edtFiltro2.Clear;
    edtFiltro3.Clear;
    pAtuIndice(lstIndices.ItemIndex);
  End;
  If (ssAlt In Shift) And CharInSet(chr(Key), ['B', 'b']) Then
  Begin
	  pSetFocus(edtFiltro1);
	End
  Else If Key = VK_Escape Then
    Close
  Else If (Key = VK_UP) And (Not blnGridFocado) Then
    cdsConsulta.Prior
  Else If (Key = VK_DOWN) And (Not blnGridFocado) Then
    cdsConsulta.Next;
end;

procedure TfrmConsultaCds.FormCreate(Sender: TObject);
begin
  strUltSelect    := '';
  bkmUltAcesso    := Nil;
  strUltIndice1   := '';
  strUltIndice2   := '';
  strUltIndice3   := '';
  intUltItemIndex := 0;
  bkmResult       := Nil;
end;

procedure TfrmConsultaCds.btnConfirmaClick(Sender: TObject);
begin
  strUltSelect    := IntToStr(cdsConsulta.RecNo);
  bkmResult       := cdsConsulta.GetBookmark;
  bkmUltAcesso    := bkmResult;

  strUltIndice1   := edtFiltro1.Text;
  strUltIndice2   := edtFiltro2.Text;
  strUltIndice3   := edtFiltro3.Text;
  intUltItemIndex := lstIndices.ItemIndex;
  ModalResult := mrOk;
end;

procedure TfrmConsultaCds.dbgConsultaDblClick(Sender: TObject);
begin
  btnConfirma.Click;
end;

procedure TfrmConsultaCds.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    btnConfirma.Click;
end;

procedure TfrmConsultaCds.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    intContador: Integer;
    strCampo: String;
begin

  For intContador := 1 To 3 Do
  Begin

    strCampo := fRetornaCampoFiltro(lstIndices.ItemIndex, intContador);

    If Column.FieldName = strCampo Then
    Begin
      dbgConsulta.Canvas.Brush.Color:= clInfoBk;
      dbgConsulta.Canvas.Font.Color:= clWindowText;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

  End;

end;

procedure TfrmConsultaCds.lstIndicesClick(Sender: TObject);
begin
  edtFiltro1.Clear;
  edtFiltro2.Clear;
  edtFiltro3.Clear;
  pAtuIndice(lstIndices.ItemIndex);
end;

procedure TfrmConsultaCds.edtFiltro1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	If (Key = VK_Return) Then
  Begin
    btnConfirma.Click;
  End
  Else If Key = VK_Escape Then
    btnSair.Click;
end;

procedure TfrmConsultaCds.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  pAfterScroll(DataSet);
end;

procedure TfrmConsultaCds.pAfterScroll(DataSet: TDataSet);
begin
  //
end;

end.
