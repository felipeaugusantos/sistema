unit untConsulta;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Uni, ExtCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, StrUtils,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  arrString = Array of String;

type
  TfrmConsulta = class(TForm)
    dbgConsulta: TDBGridCitel;
    pnlBotoes: TPanel;
    stbStatus: TStatusBar;
    Relogio: TTimer;
    qryConsulta: TUniQuery;
    dtsConsulta: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    lblBuscarPor1: TLabel;
    lblChave1: TLabel;
    lstIndices: TListBox;
    edtFiltro1: TEdit;
    edtFiltro2: TEdit;
    lblChave2: TLabel;
    lblBuscarPor2: TLabel;
    edtFiltro3: TEdit;
    lblBuscarPor3: TLabel;
    lblChave3: TLabel;
    Label2: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstIndicesClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  protected
    lstConInd,lstConDes, lstCampos : TStringList;
    lstPrimaryKey : TStringList;

    blnPrimeiraVez: Boolean;
    intRecNo: Integer;
    //Se for consulta de preço de tinta de maquina
    blnConPre: Boolean;

    procedure pDefCampos;
    procedure pAlinhaColunasNumericas;
    procedure pAjustaEdits;
    procedure pAjustaColunas;

    function fRetCampos(lstLista: TStringList): String;
    function fRetOrderBy(strIndice: String): String;
    function fContaCampos(strCampos: String): Integer;

    {*****************************************}
    {*    FUNÇÕES E PROCEDURES QUE SERÃO     *}
    {*        ---> SOBRESCRITAS <---         *}
    {**************************************MV*}
    procedure pAtuIndice(intIndice:Integer); virtual;
    function fMontaSQL(intQtdParametros: Integer; blnTodosCampos: Boolean = False): String; overload;
    function fRetOperador(strNomeCampo: String): String; virtual;

    function fAsDate(strCampo, strValor: String): String;
  public
    { Public declarations }
    blnMoveComSeta: Boolean;
    blnConfirma : Boolean;
    strNomTabela: String;
    strOrderOpc: String;
    qryTabConsulta : TUniQuery;

    {*****************************************}
    {* REFERE-SE AO REGISTRO ACESSADO NA     *}
    {* CONSULTA ANTERIOR                     *}
    {**************************************MV*}
    bkmUltAcesso: TBookMark;

    {*****************************************}
    {* VARIAVEIS REFERENTES À ÚLTIMA CONSULTA*}
    {**************************************MV*}
    strUltSelect : String;
    strUltIndice1: String;
    strUltIndice2: String;
    strUltIndice3: String;

    intUltItemIndex: Integer;

    procedure pObtendoPrimaryKey;
    function fProcessaChave(strChave: String): arrString; virtual;

    {*****************************************}
    {*    FUNÇÕES E PROCEDURES QUE SERÃO     *}
    {*        ---> SOBRESCRITAS <---         *}
    {**************************************MV*}
    function pConsulta(lstIndice, lstDesInd, lstCamposTab : TStringList):Boolean; overload;
  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses  untModulo, untfuncoesSimples;

{$R *.dfm}

{ TfrmConsulta }

procedure TfrmConsulta.pAtuIndice(intIndice: Integer);
  Var
    strSQL: String;
    strCampos: String;
    strOrderBy: String;
begin
  strCampos := fRetCampos(lstCampos);

  {*****************************************}
  {* CASO TENHA SALVO A ÚLTIMA ORDENAÇÃO   *}
  {* USADA NA CONSULTA, UTILIZAR ELA       *}
  {**************************************MV*}
{  If (Not fEmptyStr(strUltOrderBy)) And (blnPrimeiraVez) Then
  Begin
    strOrderBy     := strUltOrderBy;
    blnPrimeiraVez := False;
    pPosicionaLstIndices(strOrderBy);
  End
  Else
    strOrderBy := fRetOrderBy(lstConInd.Strings[intIndice]);}

  strOrderBy := fRetOrderBy(lstConInd.Strings[intIndice]);

  If (Not fEmptyStr(strUltSelect)) And (blnPrimeiraVez) Then
  Begin
    blnPrimeiraVez       := False;
    lstIndices.ItemIndex := intUltItemIndex;
    strSQL               := strUltSelect;
  End
  Else
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ' + strCampos + ' FROM ' + strNomTabela;

    If strNomTabela = 'CADEMP' Then
      strSQL := strSQL + ' WHERE LOCATE(EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If strNomTabela = 'CFGREL' Then
      strSQL := strSQL + ' WHERE REL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    If (Pos('ORDER BY', strOrderOpc) > 0) Then
    Begin
      strSQL := strSQL + ' ' + strOrderOpc;
      strOrderBy := '';
    End
    Else If (Pos('GROUP BY', strOrderOpc) > 0) Then
    Begin
      strSQL := strSQL + ' ' + strOrderOpc +  ' ORDER BY ' + strOrderBy;
    End
    Else
    Begin
      strSQL := strSQL + '  ORDER BY  ';
      strSQL := strSQL + strOrderBy + strOrderOpc;
    End;

  End;

	Screen.Cursor := crSQLWait;
  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
	pDefCampos;
  pAlinhaColunasNumericas;
  pAjustaEdits;
	Screen.Cursor := crDefault;
end;

function TfrmConsulta.pConsulta(lstIndice,lstDesInd,
  lstCamposTab: TStringList): Boolean;
begin
  lstIndices.Items := lstDesInd;
  lstIndices.Selected[0] := True;

  lstConInd := lstIndice;
  lstConDes := lstDesInd;
  lstCampos := lstCamposTab;
  lstIndices.Items := lstDesInd;
  blnConfirma := False;
  pObtendoPrimaryKey;
  Self.ShowModal;
	Result := blnConfirma;
end;

procedure TfrmConsulta.pDefCampos;
	Var
  	intIndTabOrigem : Integer;
    intIndBusca : Integer;
    strNomCampo : String;
begin
  For intIndTabOrigem := 0 To qryTabConsulta.FieldCount -1 Do
  Begin
  	strNomCampo := qryTabConsulta.Fields[ intIndTabOrigem ].FieldName;
    intIndBusca := 0;
    While intIndBusca < qryConsulta.FieldCount Do
    Begin

    	If ( UpperCase( qryConsulta.Fields[ intIndBusca ].FieldName ) = UpperCase( strNomCampo ) ) Then
      Begin
      	If qryTabConsulta.Fields[ intIndTabOrigem ].DataType = ftBCD Then
        Begin
          If TBCDField(qryTabConsulta.Fields[ intIndTabOrigem ]).Currency Then
  					(qryConsulta.Fields[ intIndBusca ] As TBCDField).Currency := True;
        End;

      	qryConsulta.Fields[ intIndBusca ].DisplayLabel := qryTabConsulta.Fields[ intIndTabOrigem ].DisplayLabel;
        qryConsulta.Fields[ intIndBusca ].Visible := qryTabConsulta.Fields[ intIndTabOrigem ].Visible;
        //qryConsulta.Fields[ intIndBusca ].Index := qryTabConsulta.Fields[ intIndTabOrigem ].Index;

        If (qryConsulta.Fields[ intIndBusca ].DataType = ftFloat)    Or
           (qryConsulta.Fields[ intIndBusca ].DataType = ftCurrency) Or
           (qryConsulta.Fields[ intIndBusca ].DataType = ftBCD)      Then
        Begin
          //(qryConsulta.Fields[ intIndBusca ] As TFloatField).DisplayFormat := '#,##0.00';
          Try
            (qryConsulta.Fields[ intIndBusca ] As TFloatField).DisplayFormat := TFloatField(qryTabConsulta.Fields[ intIndTabOrigem ]).DisplayFormat;
            (qryConsulta.Fields[ intIndBusca ] As TFloatField).EditFormat := TFloatField(qryTabConsulta.Fields[ intIndTabOrigem ]).EditFormat;
          Except

          End;
        End
        Else If ((qryConsulta.Fields[ intIndBusca ].DataType = ftString)     Or
                (qryConsulta.Fields[ intIndBusca ].DataType = ftWideString)) And
                (qryTabConsulta.Fields[ intIndTabOrigem ].DataType <> ftMemo) Then
        Begin

         (qryConsulta.Fields[ intIndBusca ] As TStringField).EditMask := TStringField(qryTabConsulta.Fields[ intIndTabOrigem ]).EditMask;
         
        End;

        intIndBusca := qryConsulta.FieldCount;
      End;
      Inc( intIndBusca );
    End;
  End;

end;

procedure TfrmConsulta.pObtendoPrimaryKey;
	Var
    metPrimary: TUniMetaData;
begin
  metPrimary := TUniMetaData.Create(Self);

  metPrimary.Connection := frmModulo.GetCurrentConnection;
  metPrimary.Restrictions.Clear;
  metPrimary.Restrictions.Add('TABLE_NAME=' + strNomTabela);
  metPrimary.MetaDataKind := 'IndexColumns';
  metPrimary.Filter   := 'INDEX_NAME=' + QuotedStr('PRIMARY');
  metPrimary.Filtered := True;

  metPrimary.Open;

  While Not metPrimary.Eof Do
  Begin
    lstPrimaryKey.Add(Trim(metPrimary.FieldByName('COLUMN_NAME').AsString));
    metPrimary.Next;
  End;

end;

procedure TfrmConsulta.FormShow(Sender: TObject);
begin

  Try

    If (Pos('ORDER BY', strOrderOpc) <= 0) And
       (Pos('GROUP BY', strOrderOpc) <= 0) Then
    Begin
      If Not fEmptyStr(strOrderOpc) Then
        strOrderOpc := ', ' + strOrderOpc;
    End;

    lstIndices.ItemIndex := 0;
    pAjustaEdits;
    pAjustaColunas;
    pAtuIndice(0);

    edtFiltro1.Text := strUltIndice1;
    edtFiltro2.Text := strUltIndice2;
    edtFiltro3.Text := strUltIndice3;

    {*****************************************}
    {* CASO A VARIAVEL 'intUltAcesso' ESTEJA *}
    {* SETADA, LOCALIZA E POSICIONA O REGIS- *}
    {* TRO                                   *}
    {**************************************MV*}
    If (bkmUltAcesso <> Nil)                        And
       (qryConsulta.FindField('AUTOINCREM') <> Nil) And
       (Not qryConsulta.IsEmpty) Then
    Begin
      Try
        qryConsulta.GotoBookmark(bkmUltAcesso);
      Except
        On E: EUniError Do
        Begin
          {*****************************************}
          {* CASO O REGISTRO NÃO EXISTA MAIS NA TA-*}
          {* BELA, LIMPA A VARIAVEL                *}
          {**************************************MV*}
          bkmUltAcesso := Nil;
        End;
      End;
    End;

    pSetFocus(edtFiltro1);

    Self.WindowState := wsNormal;
    Self.WindowState := wsMaximized;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConsulta.FormShow]');
    End;
  End;
end;

procedure TfrmConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    intQtdCampos: Integer;
begin
  Try
//    strUltOrderBy := fRetOrderBy(lstConInd.Strings[lstIndices.ItemIndex]);

    intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);

    {*****************************************}
    {* VERIFICA EM QUAL FORM DE CONSULTA ESTÁ*}
    {* POIS PARA CADA FORM, HÁ UMA FUNÇÃO    *}
    {* PARA MONTAR O SQL DIFERENTE           *}
    {**************************************MV*}
    If (Self.ClassType = TfrmConsulta) Then
    Begin
      strUltSelect := fMontaSQL(intQtdCampos, False);
    End;

    strUltIndice1   := edtFiltro1.Text;

    If edtFiltro2.Visible Then
      strUltIndice2 := edtFiltro2.Text;

    If edtFiltro3.Visible Then
      strUltIndice3   := edtFiltro3.Text;
      
    intUltItemIndex := lstIndices.ItemIndex;
    
    If Not blnConfirma Then
    Begin
      If Assigned(qryTabConsulta) Then
        qryTabConsulta.Close;
      qryConsulta.Close;
    End;

    FreeAndNil(lstPrimaryKey);

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConsulta.FormClose]');
    End;
  End;
end;

procedure TfrmConsulta.FormCreate(Sender: TObject);
begin
  Try
    blnMoveComSeta := True;

    qryConsulta.Connection := frmModulo.GetCurrentConnection;

//    lstConInd     := TStringList.Create;
//    lstConDes     := TStringList.Create;
      lstPrimaryKey  := TStringList.Create;
//    strUltOrderBy  := '';

    strUltSelect    := '';
    strUltIndice1   := '';
    strUltIndice2   := '';
    strUltIndice3   := '';
    intUltItemIndex := 0;

    blnPrimeiraVez := True;

    blnConPre := False;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmConsulta.FormCreate]');
    End;
  End;
end;

procedure TfrmConsulta.dbgConsultaDblClick(Sender: TObject);
begin
  If Not blnConPre Then
    btnConfirma.Click;
end;

procedure TfrmConsulta.FormKeyDown(Sender: TObject; var Key: Word;
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
    pAtuIndice(lstIndices.ItemIndex);
    edtFiltro1.Clear;
    edtFiltro2.Clear;
    edtFiltro3.Clear;
    pSetFocus(edtFiltro1);
    pDefCampos;
    pAlinhaColunasNumericas;
  End;
  If (ssAlt In Shift) And CharInSet(chr(Key), ['B', 'b']) Then
  Begin
	  pSetFocus(edtFiltro1);
	End
  Else If Key = VK_Escape Then
    Close
  Else If (Key = VK_UP) And (Not blnGridFocado) And blnMoveComSeta Then
    qryConsulta.Prior
  Else If (Key = VK_DOWN) And (Not blnGridFocado) And blnMoveComSeta Then
    qryConsulta.Next;
end;

procedure TfrmConsulta.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    arrCampos: arrString;
    intContador: Integer;

begin

  arrCampos := fProcessaChave(lstConInd.Strings[lstIndices.ItemIndex]);

//	If (Column.Field.FieldName = lstConInd.Strings[lstIndices.ItemIndex]) then
  For intContador := 0 To Length(arrCampos) - 1 Do
  Begin
    If (Column.Field.FieldName = arrCampos[intContador]) then
    Begin
      dbgConsulta.Canvas.Brush.Color:= clInfoBk;
      dbgConsulta.Canvas.Font.Color:= clWindowText;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;

  If (intRecNo = qryConsulta.RecNo) Then
  Begin
    dbgConsulta.Canvas.Font.Color  := clWhite;
    dbgConsulta.Canvas.Brush.Color := clNavy;
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmConsulta.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	If (Key = VK_Return) Then
    If Not blnConPre Then
  	  btnConfirma.Click;
end;

function TfrmConsulta.fProcessaChave(strChave: String): arrString; //marvin
  Var
    strTemp: String;
    intContador: Integer;
    strToken: String;
begin
  strTemp := '';
  strChave := strChave + '+';
  For intContador := 1 To Length(strChave) Do
  Begin
    strToken := Copy(strChave, intContador, 1);
    //If (strChave[intContador] <> '+') Then
    //  strTemp := strTemp + strChave[intContador]
    If strToken <> '+' Then
      strTemp := strTemp + strToken
    Else
    Begin
      SetLength(Result, Length(Result)+1);
      Result[length(Result)-1] := strTemp;
      strTemp := '';
    End;
  End;
end;

function TfrmConsulta.fRetCampos(lstLista: TStringList): String; //marvin
  Var
    intContador, intContador2: Integer;
    arrChave: arrString;
begin
  Result := '';
  For intContador := 0 To lstLista.Count - 1 Do
  Begin
    SetLength(arrChave, 0);
    arrChave := fProcessaChave(lstLista.Strings[intContador]);
    For intContador2 := 0 To Length(arrChave) - 1 Do
    Begin
      If (intContador = lstLista.Count - 1) And (intContador2 = Length(arrChave)-1) Then
        Result := Result + arrChave[intContador2]
      Else
        Result := Result + arrChave[intContador2] + ', ';
    End;
  End;
end;

function TfrmConsulta.fRetOrderBy(strIndice: String): String;
  Var
    intContador: Integer;
    arrChave: arrString;
begin
  arrChave := fProcessaChave(strIndice);

  For intContador := 0 To Length(arrChave) -1 Do
  Begin
    If intContador = Length(arrChave) - 1 Then
      Result := Result + arrChave[intContador]
    Else
      Result := Result + arrChave[intContador] + ', ';
  End;
end;

procedure TfrmConsulta.edtFiltro1Change(Sender: TObject);
  Var
    strSQL: String;
    intQtdCampos: Integer;
begin
  intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);

  If qryConsulta.Active Then
  Begin
    strSQL := fMontaSQL(intQtdCampos);
    If Not fEmptyStr(strSQL) Then
    Begin
      With qryConsulta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
      End;
      pDefCampos;
      pAlinhaColunasNumericas;
    End;
  End;
end;

procedure TfrmConsulta.edtFiltro1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	If (Key = VK_Return) Then
  Begin
    btnConfirma.Click;
  End
  Else If Key = VK_Escape Then
    btnSair.Click;
end;

function TfrmConsulta.fRetOperador(strNomeCampo: String): String;
begin
  If qryTabConsulta.FieldByName(strNomeCampo).DataType In [ftString, ftWideString] Then
    Result := 'LIKE'
  Else If qryTabConsulta.FieldByName(strNomeCampo).DataType In [ftDate, ftDateTime] Then
    Result := 'DATE'
  Else
    Result := '=';
end;

procedure TfrmConsulta.lstIndicesClick(Sender: TObject);
begin
  edtFiltro1.Clear;
  pAtuIndice(lstIndices.ItemIndex);
  lblChave1.Caption := lstConDes.Strings[lstIndices.ItemIndex];
  pSetFocus(edtFiltro1);
  //pDefCampos;
  pAlinhaColunasNumericas;
end;

function TfrmConsulta.fMontaSQL(intQtdParametros: Integer; blnTodosCampos: Boolean = False): String;
  Var
    strSQL: String;
    strOperador: String;
    strCampo: String;
    strCamposTab, strOrderBy: String;
    strNomeCampo: String;
    intContador: Integer;
    intIndCampo: Integer;
    strValorData: String;
begin
  intIndCampo   := lstIndices.ItemIndex;
  strCamposTab  := fRetCampos(lstCampos);
  strOrderBy    := fRetOrderBy(lstConInd.Strings[intIndCampo]);
  strNomeCampo  := lstConInd.Strings[intIndCampo];
  strValorData  := '';

  intContador := 0;
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  If Not blnTodosCampos Then
    strSQL := strSQL + strCamposTab
  Else
    strSQL := strSQL + ' * ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomTabela;

  Case intQtdParametros Of
  1:Begin
      If Trim(edtFiltro1.Text) <> '' Then
      Begin
        strCampo := strNomeCampo;
        strSQL := strSQL + ' WHERE ';
        strOperador := fRetOperador(strCampo);
        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro1.Text);
          strSQL := strSQL + strValorData;
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;
      End;
    End;

  2:Begin
      If Trim(edtFiltro1.Text) <> '' Then
      Begin
        Inc(intContador);
        strSQL := strSQL + ' WHERE ';
        strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');
        strOperador := fRetOperador(strCampo);

        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro1.Text);
          strSQL := strSQL + strValorData
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;
      End;
      If (Trim(edtFiltro2.Text) <> '') Then
      Begin
        If intContador = 0 Then
          strSQL := strSQL + ' WHERE '
        Else
          strSQL := strSQL + ' AND ';

        strCampo := AnsiReplaceStr(Copy(strNomeCampo, Pos('+', strNomeCampo), Length(strNomeCampo)), '+', '');
        strOperador := fRetOperador(strCampo);
        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro2.Text);
          strSQL := strSQL + strValorData
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;
      End;
    End;

  3:Begin

      If Trim(edtFiltro1.Text) <> '' Then
      Begin
        Inc(intContador);
        strSQL := strSQL + ' WHERE ';
        strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)-1), '+', '');
        strOperador := fRetOperador(strCampo);

        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro1.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro2.Text);
          strSQL := strSQL + strValorData
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro1.Text;
      End;
      Delete(strNomeCampo, 1, Pos('+', strNomeCampo));

      If Trim(edtFiltro2.Text) <> '' Then
      Begin
        If intContador = 0 Then
          strSQL := strSQL + ' WHERE '
        Else
          strSQL := strSQL + ' AND ';

        Inc(intContador);
        strCampo := AnsiReplaceStr(Copy(strNomeCampo, 1, Pos('+', strNomeCampo)), '+', '');
        strOperador := fRetOperador(strCampo);
        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro2.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro2.Text);
          strSQL := strSQL + strValorData
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro2.Text;
      End;
      Delete(strNomeCampo, 1, Pos('+', strNomeCampo));

      If (edtFiltro3.Text <> '') Then
      Begin
        If intContador = 0 Then
          strSQL := strSQL + ' WHERE '
        Else
          strSQL := strSQL + ' AND ';

        strCampo := strNomeCampo;
        strOperador := fRetOperador(strCampo);
        If strOperador = 'LIKE' Then
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + QuotedStr(edtFiltro3.Text + '%')
        Else If strOperador = 'DATE' Then
        Begin
          strValorData := fAsDate(strCampo, edtFiltro3.Text);
          strSQL := strSQL + strValorData
        End
        Else
          strSQL := strSQL + strCampo + ' ' + strOperador + ' ' + edtFiltro3.Text;
      End;
    End;

  End;

  If strNomTabela = 'CADEMP' Then
  Begin
    If (edtFiltro1.Text = '') And (edtFiltro2.Text = '') And (edtFiltro3.Text = '') Then
      strSQL := strSQL + ' WHERE LOCATE(EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
    Else
      strSQL := strSQL + ' AND LOCATE(EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  End;

  If strNomTabela = 'CFGREL' Then
  Begin
    If (fEmptyStr(edtFiltro1.Text)) And (fEmptyStr(edtFiltro2.Text)) And (fEmptyStr(edtFiltro3.Text)) Then
      strSQL := strSQL + ' WHERE REL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' '
    Else
      strSQL := strSQL + ' AND REL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  End;

  If (Pos('ORDER BY', strOrderOpc) > 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc;
    strOrderBy := '';
  End
  Else If (Pos('GROUP BY', strOrderOpc) > 0) Then
  Begin
    strSQL := strSQL + ' ' + strOrderOpc +  ' ORDER BY ' + strOrderBy;
  End
  Else
  Begin
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + strOrderBy + strOrderOpc;
  End;

  Result := strSQL;
end;

function TfrmConsulta.fContaCampos(strCampos: String): Integer; //Marvin
  Var
    strTmpCampos: String;
begin
  strTmpCampos := strCampos;
{  Result := 0;
  If Trim(strCampos) <> '' Then
  Begin
    If Pos('+', strCampos) = 0 Then
      Result := 1
    Else
    Begin
      Result := 2;
      Delete(strCampos, 1, Pos('+', strCampos));
      If Pos('+', strCampos) > 0 Then
        Result := 3;
    End;
  End;}
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

procedure TfrmConsulta.pAjustaEdits; //Marvin
  Var
    intQtdIndices: Integer;
    strCampo: String;
begin
  intQtdIndices := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);
  strCampo := lstIndices.Items.Strings[lstIndices.ItemIndex];
  If intQtdIndices > 1 Then
  Begin
    lblChave1.Caption  := Copy(strCampo, 1, Pos('/', strCampo)-1);
    Delete(strCampo, 1, Pos('/', strCampo));
    If intQtdIndices = 2 Then
    Begin
      lblBuscarPor2.Visible := True;
      lblChave2.Visible     := True;
      edtFiltro2.Visible    := True;
      lblChave3.Visible     := False;
      edtFiltro3.Visible    := False;
      lblBuscarPor3.Visible := False;
      lblChave2.Caption     := strCampo;
    End
    Else
    Begin
      lblBuscarPor2.Visible := True;
      lblChave2.Visible  := True;
      edtFiltro2.Visible := True;
      lblChave2.Caption  := Copy(strCampo, 1, Pos('/', strCampo)-1);

      Delete(strCampo, 1, Pos('/', strCampo));
      lblBuscarPor2.Visible := True;
      lblChave3.Visible     := True;
      edtFiltro3.Visible    := True;
      lblChave3.Caption     := strCampo;
      lblBuscarPor3.Visible := True;
    End;
  End
  Else
  Begin
    lblChave1.Caption     := strCampo;
    lblBuscarPor2.Visible := False;
    lblChave2.Visible     := False;
    edtFiltro2.Visible    := False;
    lblChave3.Visible     := False;
    edtFiltro3.Visible    := False;
    lblBuscarPor3.Visible := False
  End;
end;

procedure TfrmConsulta.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
    intQtdCampos: Integer;
begin
  intQtdCampos := fContaCampos(lstConInd.Strings[lstIndices.ItemIndex]);

  If (qryConsulta.FieldList.Find('AUTOINCREM') = Nil) Or
     (qryConsulta.IsEmpty)                            Then
  Begin
    strSQL := fMontaSQL(intQtdCampos, True);
    If Assigned(bkmUltAcesso) Then
      bkmUltAcesso := Nil;
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strNomTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' AUTOINCREM = ' + QuotedStr(qryConsulta.FieldByName('AUTOINCREM').AsString);

    bkmUltAcesso := qryConsulta.GetBookmark;
  End;

  If Not fEmptyStr(strSQL) Then
  Begin
    With qryTabConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;
  End;
  blnConfirma := True;

  Close;

end;

procedure TfrmConsulta.btnSairClick(Sender: TObject);
begin
	blnConfirma := False;
  Self.Close;
end;


function TfrmConsulta.fAsDate(strCampo, strValor: String): String;
  Var
    dtaTemp: TDateTime;
begin

  {*****************************************}
  {* "1 = 1" -> PEQUENO HACK PARA QUE,     *}
  {* QUANDO A DATA DIGITADA NAO FOR VALIDA,*}
  {* EX: '12/0' NÃO APRESENTE ERRO E IGNORE*}
  {* O FILTRO DE DATA                      *}
  {**************************************MV*}
  strValor := AnsiReplaceStr(strValor, '/', FormatSettings.DateSeparator);
  strValor := AnsiReplaceStr(strValor, '-', FormatSettings.DateSeparator);
  Try
    dtaTemp := StrToDate(strValor);
    strValor := FormatDateTime('yyyy-mm-dd', dtaTemp);

    Result := strCampo + ' = ' + QuotedStr(strValor);
  Except
    Result := ' 1 = 1 ';
  End;
end;

procedure TfrmConsulta.pAjustaColunas;
  Var
    intContador: Integer;
    lstCamposCol: TStringList;
    strCampo: String;
begin

  If (lstCampos = Nil)      Or
     (lstCampos.Count <= 0) Then
  Begin
    Exit;
  End;

  Try
    lstCamposCol := TStringList.Create;

    For intContador := 0 To lstCampos.Count -1 Do
    Begin

      If Pos('+', lstCampos[intContador]) <= 0 Then
      Begin
        lstCamposCol.Add(lstCampos[intContador]);
      End
      Else
      Begin
        strCampo := lstCampos[intContador];
        While (Pos('+', strCampo) > 0) Do
        Begin
          lstCamposCol.Add(Copy(strCampo, 1, Pos('+', strCampo)-1));
          Delete(strCampo, 1, Pos('+', strCampo));
        End;
        lstCamposCol.Add(strCampo);
      End;

    End;

    For intContador := 0 To qryTabConsulta.FieldCount -1 Do
    Begin
      qryTabConsulta.Fields[intContador].Index := 999;
    End;

    For intContador := 0 To lstCamposCol.Count -1 Do
    Begin
      qryTabConsulta.FieldByName(lstCamposCol.Strings[intContador]).Index := intContador;
    End;

  Finally
    FreeAndNil(lstCamposCol);
  End;

end;

procedure TfrmConsulta.pAlinhaColunasNumericas;
  Var
    intIndBusca: Integer;
    strValTmp: String;
begin
  qryConsulta.DisableControls;

  For intIndBusca := 0 To qryConsulta.FieldCount -1 Do
  Begin
    If (qryConsulta.Fields[ intIndBusca ].DataType = ftFloat)    Or
       (qryConsulta.Fields[ intIndBusca ].DataType = ftCurrency) Or
       (qryConsulta.Fields[ intIndBusca ].DataType = ftBCD)      Then
    Begin
      (qryConsulta.Fields[ intIndBusca ] As TFloatField).Alignment := taRightJustify;
    End
    Else If (qryConsulta.Fields[ intIndBusca ].DataType = ftString) Then
    Begin
      strValTmp := qryConsulta.Fields[ intIndBusca ].AsString;
      If (Pos('.', strValTmp) > 0) Then
      Begin
        strValTmp := AnsiReplaceStr(strValTmp, ',', '');
        If (fIsNumber(AnsiReplaceStr(strValTmp, '.', ''))) Then
        Begin
          (qryConsulta.Fields[ intIndBusca ] As TStringField).Alignment := taRightJustify;
        End;
      End;
    End
    Else If (qryConsulta.Fields[ intIndBusca ].DataType = ftDate) Then
    Begin
      (qryConsulta.Fields[ intIndBusca ] As TDateField).EditMask := '99/99/9999;1;_';
    End;
  End;

  qryConsulta.EnableControls;
end;

procedure TfrmConsulta.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  intRecNo := qryConsulta.RecNo;
  dbgConsulta.Refresh;
end;

procedure TfrmConsulta.FormPaint(Sender: TObject);
begin
  btnSair.Left := (pnlBotoes.Width-(btnSair.Width+10));
  btnSair.Top := 3;
end;

end.


