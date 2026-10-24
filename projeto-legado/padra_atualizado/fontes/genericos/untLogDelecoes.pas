unit untLogDelecoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, StdCtrls, Mask, MaskEditFocus, Menus,
  Buttons, ExtCtrls, EditFocus, DB, StrUtils, Uni, AppEvnts,
  BitBtnLockedIncrem;

type
  TLastField = Record
    intIndCol : integer;
    ftyTipCam : TFieldType;
    strNomCam : String;
  End;

  TfrmLogDelecoes = class(TfrmPai)
    pnlTopo: TPanel;
    lblDtaDel: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    dbgLogErr: TDBGridCitel;
    Label3: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    pnlPesquisa: TPanel;
    lblPesquisa: TLabel;
    lblNomeCampo: TLabel;
    edtData: TMaskEditFocus;
    edtNumero: TEditFocus;
    edtString: TEditFocus;
    Label2: TLabel;
    edtValor: TEditFocus;
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure pAtulizaGrid(blnLike: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgLogErrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgLogErrTitleClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgLogErrDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    {************************************************}
    {*  VARIAVEL QUE GUARDA A ULTIMA COLUNA CLICADA *}
    {*********************************************LA*}
    lflLastField : TLastField;

    qryGenDel : TUniQuery;
    dtsGenDel : TDataSource;

    procedure pAbrePesquisa;
    procedure pProximaOrdenacao;
    procedure pMascaraValor;
    procedure pPegaProximaColuna;
    
    function fRetOperador(ftyTipCam : TFieldType): String;
    function fAsDate(strCampo, strValor: String): String;

  public
    { Public declarations }
    strTabela: String;
  end;


implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftWord,ftFloat];

procedure TfrmLogDelecoes.edtCodOpeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodOpe.Text) Then
    edtDesOpe.Text := 'TODOS'
  Else
    edtDesOpe.Text := fRetNomeOperador(edtCodOpe.Text);

  If fEmptyStr(edtDesOpe.Text) And (Not fEmptyStr(edtCodOpe.Text))  Then
  Begin
    fMensagem('AVISO','Código do operador não encontrado.', ['&O K']);
    edtCodOpe.Clear;
    pSetFocus(edtCodOpe);
  End;

  pAtulizaGrid(False);

end;

procedure TfrmLogDelecoes.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqOperador(Self, edtCodOpe, edtDesOpe, qryTabela, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

{******************************************************}
{*  RETORNA O OPERADOR DE ACORDO COM O TIPO DE DADO   *}
{***************************************************LA*}
function TfrmLogDelecoes.fRetOperador(ftyTipCam : TFieldType): String;
begin
  Case ftyTipCam Of
    ftString,
    ftWideString : Result := 'LIKE';
    ftDate,
    ftDateTime   : Result := 'DATE';
    Else           Result := '=';
  End;
end;

{***************************************}
{*  MONTA A SQL PARA COMPARAR DATA     *}
{************************************LA*}
function TfrmLogDelecoes.fAsDate(strCampo, strValor: String): String;
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

procedure TfrmLogDelecoes.pAtulizaGrid(blnLike: Boolean);
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strTabela;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or
     (Not fEmptyStr(edtCodOpe.Text)) Then
  Begin
    strSQL := strSQL + ' WHERE ';
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      strSQL := strSQL + '  DTADEL BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  DTADEL >= :DTAINI ';

  End;

  If Not fEmptyStr(edtCodOpe.Text) Then
  Begin

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + ' AND ';

    strSQL := strSQL + '  OPEDEL = :CODOPE ';

  End;

  If lflLastField.intIndCol <> -1 Then
  Begin
    If blnLike Then
      Case lflLastField.ftyTipCam Of
        ftDate,
        ftDateTime :  strSQL := strSQL + ' AND ' + fAsDate(lflLastField.strNomCam,edtData.Text);
                                                                        
        ftString,
        ftWideString: strSQL := strSQL + ' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

        ftInteger,
        ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                        strSQL := strSQL + ' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

        ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                        strSQL := strSQL + ' AND ' + lflLastField.strNomCam +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';
     End;

    strSQL := strSQL + ' ORDER BY ' + lflLastField.strNomCam;
  End;

  With qryGenDel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(edtCodOpe.Text) Then
    Begin
      ParamByName('CODOPE').AsString := edtCodOpe.Text;
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End
      Else
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      End;

    End;

    If blnLike Then
    Begin
      Case lflLastField.ftyTipCam Of
        ftString,
        ftWideString: ParamByName('CODPES').AsString  := edtString.Text + '%';

        ftInteger,
        ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                        ParamByName('CODPES').AsInteger := StrToIntDef(Trim(edtNumero.Text),0);

        ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                        ParamByName('CODPES').AsFloat := fStrToFloat(Trim(edtValor.Text));

      End;
    End;

    Open;

    pMascaraValor;

    If lflLastField.intIndCol <> -1 Then
      dbgLogErr.SelectedField := fieldbyname(lflLastField.strNomCam);

  End;

End;

procedure TfrmLogDelecoes.FormCreate(Sender: TObject);
begin
  inherited;

  qryGenDel := fCriaQuery(Self);
  dtsGenDel := fCriaDataSource(qryGenDel);
  dbgLogErr.DataSource := dtsGenDel;

  fFecharTabela(qryGenDel);

  lflLastField.intIndCol := -1;

end;

procedure TfrmLogDelecoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryGenDel);
end;

procedure TfrmLogDelecoes.dbgLogErrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Escape Then
  Begin
    If pnlPesquisa.Visible Then
    Begin
      pnlPesquisa.Visible := False;
    End
    Else
    Begin
     inherited;

      If qryGenDel.Active Then
      Begin
        fFecharTabela(qryGenDel);
        pSetFocus(mskDtaIni);
        Exit;
      End;

      Close;
    End;
  End;

end;

procedure TfrmLogDelecoes.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

procedure TfrmLogDelecoes.dbgLogErrTitleClick(Column: TColumn);
begin
  inherited;
  pnlPesquisa.Visible := false;
    
  If Not qryGenDel.IsEmpty Then
  With lflLastField Do
  Begin
    intIndCol := Column.Index;
    ftyTipCam := Column.Field.DataType;
    strNomCam := Column.Field.FieldName;
  End;
  pAtulizaGrid(False);
end;

{**********************************************************}
{* ABRE O PANEL DE PESQUISA DE ACORDO COM O TIPO DO CAMPO *}
{* PARA DIGITAR O VALOR A SER PESQUISADO                  *}
{*******************************************************LA*}
procedure TfrmLogDelecoes.pAbrePesquisa;
Begin
  If lflLastField.intIndCol = -1 Then
    pPegaProximaColuna;

  If (lflLastField.intIndCol > -1) Then
  Begin
    If lflLastField.ftyTipCam in SET_OF_TYPES Then
    Begin
      lblNomeCampo.Caption := lflLastField.strNomCam + ':';
      pnlPesquisa.Visible  := True;

      Case lflLastField.ftyTipCam Of
        ftString,
        ftWideString: Begin
                       edtData.Visible          := False;
                       edtString.Visible        := True;
                       edtNumero.Visible        := False;
                       edtString.Left           := edtData.Left;
                       edtValor.Visible         := False;
                       ActiveControl            := edtString;
                       lblPesquisa.FocusControl := edtString;
                     End;
        ftDate,
        ftDateTime : Begin
                       edtData.Visible          := True;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;
                       ActiveControl            := edtData;
                       lblPesquisa.FocusControl := edtData;
                     End;
        ftInteger,
        ftWord     : Begin
                       edtData.Visible   := False;
                       edtString.Visible := False;
                       edtNumero.Visible := True;
                       edtNumero.Left    := edtData.Left;
                       edtValor.Visible  := False;
                       ActiveControl     := edtNumero;
                       lblPesquisa.FocusControl := edtNumero;
                     End;
        ftFloat     : Begin
                       edtData.Visible          := False;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := True;
                       edtValor.Left            := edtData.Left;
                       ActiveControl            := edtValor;
                       lblPesquisa.FocusControl := edtValor;
                     End;
      End;
    End
    Else
      fMensagem('', 'Somente campos do tipo data, texto, numérico ou valor podem ser pesquisados.', ['&O k']);
  End
  Else
    fMensagem('', 'Escolha um campo de ordenação clicando no título de uma coluna.', ['&O k']);
End;


{******************************************************************************}
{* PROCURA A PROXIMA COLUNA PARA ORDENAR - SE CHEGAR AO FINAL VOLTA AO COMEÇO *}
{***************************************************************************LA*}
procedure TfrmLogDelecoes.pPegaProximaColuna;
  Var
    intIndex: integer;
    intCount: integer;
Begin
  intCount := 0;
  intIndex := lflLastField.intIndCol;

    If qryGenDel.Active Then
    Repeat
      inc(intIndex);
      If intIndex > dbgLogErr.Columns.Count - 1 Then
        intIndex := 0;
      inc(intCount);

      If dbgLogErr.Columns.Items[intIndex].Field.DataType In SET_OF_TYPES Then
      With lflLastField Do
      Begin
        intIndCol := intIndex;
        ftyTipCam := dbgLogErr.Columns.Items[intIndex].Field.DataType;
        strNomCam := dbgLogErr.Columns.Items[intIndex].Field.FieldName;

        exit;
      End;
    Until (intCount > dbgLogErr.Columns.Count);
End;

{***********************************************************}
{*  COLOCA MASCARA NOS CAMPOS DE VALOR DA GRID             *}
{********************************************************LA*}
procedure TfrmLogDelecoes.pMascaraValor;
  Var
    intIndex: integer;
Begin
  If Not qryGenDel.IsEmpty Then
    With dbgLogErr.Columns Do
    For intIndex := 1 To Count - 1 Do
      If Items[intIndex].Field.DataType = ftFloat Then
        (Items[intIndex].Field As TFloatField).DisplayFormat := '#0.00';
End;

{************************************************************}
{*  ORDENA PELA PROXIMA COLUNA A PARTIR DA COLLUNA CORRENTE *}
{**********************************************************LA*}
procedure TfrmLogDelecoes.pProximaOrdenacao;
Begin
  pnlPesquisa.Visible := false;

  If Not qryGenDel.Active Then
    lflLastField.intIndCol := -1
  Else
    pPegaProximaColuna;

  pAtulizaGrid(False);
End;

procedure TfrmLogDelecoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F3    : pProximaOrdenacao;
    VK_F5    : pAbrePesquisa;
    VK_RETURN: If pnlPesquisa.Visible Then
               Begin
                 pAtulizaGrid(True);
                 ActiveControl := pnlPesquisa;
               End
               Else
                 inherited;
    Else       inherited;
  End;
end;

procedure TfrmLogDelecoes.dbgLogErrDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgLogErr.Canvas.Brush.Color:= clInfoBk;
    dbgLogErr.Canvas.Font.Color:= clWindowText;
    dbgLogErr.Canvas.FillRect(Rect);
    dbgLogErr.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

end.

