unit untPaiOrdena;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, Menus, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet,
  UniDataSetProvider, Uni, Grids, DBGridCitel, DBGrids, EditFocus, Mask, MaskEditFocus, StrUtils,
  AppEvnts, BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftLargeInt,ftWord,ftFloat];

type
  TLastField = Record
    intIndCol : integer;
    ftyTipCam : TFieldType;
    strNomCam,
    strNomCol : String;
  End;

  TfrmPaiOrdena = class(TfrmPaiEdit)
    pnlHeader: TPanel;
    pnlTail: TPanel;
    dbgConsulta: TDBGridCitel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    pnlPesquisa: TPanel;
    lblPesquisa: TLabel;
    lblNomeCampo: TLabel;
    edtData: TMaskEditFocus;
    edtNumero: TEditFocus;
    edtString: TEditFocus;
    edtValor: TEditFocus;
    btnPesquisar: TBitBtnLocked;
    btnMudaOrdem: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure dbgConsultaDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    Function fEstaNoHeader: Boolean;

    procedure pProximaOrdenacao;
    procedure pPegaProximaColuna;
    procedure pAbrePesquisa;

  public
    { Public declarations }
    intDigDec            : Integer;
    blnTemSelecao        : Boolean;
    blnTemMarcacao       : Boolean;
    blnSempreRelerBanco  : Boolean;
    blnSelecionaComEnter : Boolean;
    blnSelecionaComEspaco: Boolean;
    blnTemPesquisa       : Boolean;
    blnPodeIncluir       : Boolean;
    blnFindNextOutros    : Boolean;
    stlListSelecao       : TStringList;
    blnQuoteLista        : Boolean;
    strCampoLista        : String;
    intCorSelecao        : Integer;
    blnOrdemDesc         : Boolean;

    Procedure pMarcaTodos;
    Procedure pDesmarcaTodos;
    procedure pLimpaEventoEdits;
    procedure pLimpaPesquisa;
    function fFiltraSQL(blnLike: Boolean): String; virtual;

    function fAsDate(strCampo, strValor: String): String;
    function fRetOperador(ftyTipCam : TFieldType): String;

  protected
    lflLastField : TLastField;

    function fGetSql(blnLike: Boolean): String; Virtual;
    function fGetOrderBy: String; Virtual;
    function fSetParametros: Boolean; Virtual;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; Virtual;
    function fInLista: Boolean; Virtual;
    function fGetActiveControl: TWinControl; Virtual;
    function fGetAliasField(strCampo: String): String; Virtual;
    function fGetFilter: String; Virtual;
    Function fGetNomePesquisa: String; Virtual;
    Function fRetChaveLista: String; Virtual;

    Procedure pSetFilterDefault; Virtual;
    procedure pAddListaQuery; Virtual;
    procedure pMascaraValor; Virtual;
    procedure pAcaoAdd; Virtual;
    procedure pAcaoDel; Virtual;
    procedure pAcaoAbort; Virtual;
    procedure pRefresh; virtual;
    Procedure pOrdenaClient; Virtual;
 end;

var
  frmPaiOrdena: TfrmPaiOrdena;

implementation

uses untFuncoesFactory, untIFuncoes, untModulo, System.UITypes;

{$R *.dfm}

Procedure TfrmPaiOrdena.pSetFilterDefault;
Begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
End;

function TfrmPaiOrdena.fSetParametros: Boolean;
Begin
  Result := TRUE;
End;

function TfrmPaiOrdena.fGetActiveControl: TWinControl;
Begin
  Result := NIL;
End;

{******************************************************}
{*  RETORNA O OPERADOR DE ACORDO COM O TIPO DE DADO   *}
{***************************************************LA*}
function TfrmPaiOrdena.fRetOperador(ftyTipCam : TFieldType): String;
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
function TfrmPaiOrdena.fAsDate(strCampo, strValor: String): String;
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

    If blnSempreRelerBanco Then
      strValor := FormatDateTime('yyyy-mm-dd', dtaTemp)
    Else
      strValor := FormatDateTime('dd/mm/yyyy', dtaTemp);

    Result := strCampo + ' = ' + QuotedStr(strValor);
  Except
    Result := ' 1 = 1 ';
  End;
end;

{***********************************************************}
{*  COLOCA MASCARA NOS CAMPOS DE VALOR DA GRID             *}
{********************************************************LA*}
procedure TfrmPaiOrdena.pMascaraValor;
  Var
    intIndex: integer;
Begin
  If cdsConsulta.Active Then
    With dbgConsulta.Columns Do
    For intIndex := 1 To Count - 1 Do
      Case Items[intIndex].Field.DataType Of
        ftFloat: TFloatField(Items[intIndex].Field).DisplayFormat := fMskDigitos(intDigDec); //'#0.00';
        ftDate : TFloatField(Items[intIndex].Field).EditMask      := '99/99/9999;1;_';
      End;
End;

function TfrmPaiOrdena.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
End;

function TfrmPaiOrdena.fGetOrderBy: String;
Begin
  if Not fEmptyStr(lflLastField.strNomCam) Then
    Result := ' ORDER BY ' + fGetAliasField(lflLastField.strNomCam) + IfThen(blnOrdemDesc, ' DESC ', '') ;

  If Not blnSempreRelerBanco Then
    pOrdenaClient;
End;

function TfrmPaiOrdena.fGetFilter: String;
Begin
  Result := '';

  With qryConsulta Do
  Try
    If lflLastField.intIndCol <> -1 Then
    Begin

        Case lflLastField.ftyTipCam Of
          ftDate,
          ftDateTime : Result := fAsDate(fGetAliasField(lflLastField.strNomCam),edtData.Text);

          ftString,
          ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                          Result := 'UPPER('+fGetAliasField(lflLastField.strNomCam) +  ') ' +
                                    fRetOperador(lflLastField.ftyTipCam) + QuotedStr(edtString.Text + '%');

          ftInteger,
          ftLargeInt,
          ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                          Result := fGetAliasField(lflLastField.strNomCam) +  ' ' +
                                    fRetOperador(lflLastField.ftyTipCam) + IntToStr(StrToIntDef(Trim(edtNumero.Text),0));

          ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                          Result := fGetAliasField(lflLastField.strNomCam) +  ' ' +
                                    fRetOperador(lflLastField.ftyTipCam) + FloatToStr(fStrToFloat(Trim(edtValor.Text)));
       End;

    End;

  Except
    Result := '';
  End;
End;

function TfrmPaiOrdena.fFiltraSQL(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  With qryConsulta, Sql Do
  Try
    If lflLastField.intIndCol <> -1 Then
    Begin
      If blnLike Then
        Case lflLastField.ftyTipCam Of
          ftDate,
          ftDateTime : strSQL := strSQL + ' AND ' + fAsDate(fGetAliasField(lflLastField.strNomCam),edtData.Text);

          ftString,
          ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                          strSQL := strSQL + ' AND ' + fGetAliasField(lflLastField.strNomCam) +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

          ftInteger,
          ftLargeInt,
          ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                          strSQL := strSQL + ' AND ' + fGetAliasField(lflLastField.strNomCam) +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';

          ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                          strSQL := strSQL + ' AND ' + fGetAliasField(lflLastField.strNomCam) +  '  ' + fRetOperador(lflLastField.ftyTipCam) + ' :CODPES ';
       End;

    End;

    Result := strSQL;

  Except
    Result := '';
  End;
End;

function TfrmPaiOrdena.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add(fGetSql(blnLike));

      Add(fFiltraSQL(blnLike));

      Add(fGetOrderBy);

      If blnLike Then
      Begin
        Case lflLastField.ftyTipCam Of
          ftString,
          ftWideString: If not fEmptyStr(Trim(edtString.Text)) Then
                          ParamByName('CODPES').AsString  := edtString.Text + '%';
          ftInteger,
          ftLargeInt,
          ftWord      : If StrToIntDef(Trim(edtNumero.Text),0) <> 0 Then
                          ParamByName('CODPES').AsInteger := StrToIntDef(Trim(edtNumero.Text),0);

          ftFloat     : If fStrToFloat(Trim(edtValor.Text)) <> 0 Then
                          ParamByName('CODPES').AsFloat := fStrToFloat(Trim(edtValor.Text));

        End;
      End;

      If Not fSetParametros Then
      Begin
        Result := False;
        Exit;
      End;

      Open;

      If Assigned(dspConsulta.DataSet) Then
        pSetaClient(dspConsulta.DataSet);

      cdsConsulta.Open;

      pSetFilterDefault;

      pMascaraValor;

      If lflLastField.intIndCol <> -1 Then
      Begin
        dbgConsulta.SelectedField := fieldbyname(lflLastField.strNomCam);
      End;

      If (Not pnlPesquisa.Visible) And dbgConsulta.CanFocus Then
        pSetFocus(dbgConsulta);

      Result := True;
    End;

    blnMudarFoco := FALSE;
  Except

    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmPaiOrdena.fAbreConsulta]');
      Result := False;
    End;

  End;
End;

{************************************************************}
{*  ORDENA PELA PROXIMA COLUNA A PARTIR DA COLLUNA CORRENTE *}
{**********************************************************LA*}
procedure TfrmPaiOrdena.pProximaOrdenacao;
Begin
  If Not blnTemPesquisa Then
    Exit;

  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;

  pnlPesquisa.Visible := false;

  If Not cdsConsulta.Active Then
    lflLastField.intIndCol := -1
  Else
    pPegaProximaColuna;

  If blnSempreRelerBanco Then
    fAbreConsulta(False)
  Else
  Begin
    pSetFilterDefault;
    pOrdenaClient;
  End;

  pRefresh;
End;

{******************************************************************************}
{* PROCURA A PROXIMA COLUNA PARA ORDENAR - SE CHEGAR AO FINAL VOLTA AO COMEÇO *}
{***************************************************************************LA*}
procedure TfrmPaiOrdena.pPegaProximaColuna;
  Var
    intIndex: integer;
    intCount: integer;
Begin
  intCount := 0;
  intIndex := lflLastField.intIndCol;

    If cdsConsulta.Active Then
    Repeat
      inc(intIndex);
      If intIndex > dbgConsulta.Columns.Count - 1 Then
        intIndex := 0;
      inc(intCount);

      If dbgConsulta.Columns.Items[intIndex].Visible And
        (dbgConsulta.Columns.Items[intIndex].Field.FieldKind <> fkLookup) And //OCORRE ERROS NOS CAMPOS LOOKUP       
        (dbgConsulta.Columns.Items[intIndex].Field.DataType In SET_OF_TYPES) Then
      With lflLastField Do
      Begin
        intIndCol := intIndex;
        ftyTipCam := dbgConsulta.Columns.Items[intIndex].Field.DataType;
        strNomCam := dbgConsulta.Columns.Items[intIndex].Field.FieldName;
        strNomCol := dbgConsulta.Columns.Items[intIndex].Title.Caption;

        exit;
      End;
    Until (intCount > dbgConsulta.Columns.Count);
End;

procedure TfrmPaiOrdena.pLimpaPesquisa;
begin
  pnlPesquisa.Visible := False;
  edtData.Clear;
  edtNumero.Clear;
  edtString.Clear;
  edtValor.Clear;

  If blnSempreRelerBanco Then
    fAbreConsulta(True)
  Else
    pSetFilterDefault;
    
End;

{**********************************************************}
{* ABRE O PANEL DE PESQUISA DE ACORDO COM O TIPO DO CAMPO *}
{* PARA DIGITAR O VALOR A SER PESQUISADO                  *}
{*******************************************************LA*}
procedure TfrmPaiOrdena.pAbrePesquisa;
Begin
  If Not blnTemPesquisa Then
    Exit;

  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;

  If lflLastField.intIndCol = -1 Then
    pPegaProximaColuna;

  If (lflLastField.intIndCol > -1) Then
  Begin
    If lflLastField.ftyTipCam in SET_OF_TYPES Then
    Begin

      lblNomeCampo.Caption := fGetNomePesquisa;

      pnlPesquisa.Visible  := True;

      Case lflLastField.ftyTipCam Of
        ftString,
        ftWideString: Begin
                       edtString.Left           := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := False;
                       edtString.Visible        := True;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;
                       pSetFocus(edtString);
                       lblPesquisa.FocusControl := edtString;
                     End;
        ftDate,
        ftDateTime : Begin
                       edtData.Left             := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := True;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := False;

                       pSetFocus(edtData);
                         
                       lblPesquisa.FocusControl := edtData;
                     End;
        ftInteger,
        ftLargeInt,
        ftWord     : Begin
                       edtNumero.Left    := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible   := False;
                       edtString.Visible := False;
                       edtNumero.Visible := True;
                       edtValor.Visible  := False;
                       pSetFocus(edtNumero);
                       lblPesquisa.FocusControl := edtNumero;
                     End;
        ftFloat     : Begin
                       edtValor.Left            := lblNomeCampo.Left + lblNomeCampo.Width + 2;
                       edtData.Visible          := False;
                       edtString.Visible        := False;
                       edtNumero.Visible        := False;
                       edtValor.Visible         := True;
                       pSetFocus(edtValor);
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

Function TfrmPaiOrdena.fEstaNoHeader: Boolean;
  Var
    wctControl : TWinControl;
Begin
  wctControl := ActiveControl;
  While wctControl <> Nil Do
  Begin
    If wctControl.Parent = pnlHeader Then
    Begin
      Result := TRUE;
      Exit;
    End Else
      wctControl := wctControl.Parent;
  End;
  
  Result := FALSE;
End;

procedure TfrmPaiOrdena.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F3    : pProximaOrdenacao;
    VK_F5    : pAbrePesquisa;
    VK_RETURN: If pnlPesquisa.Visible And
                  ( edtdata.Focused   Or edtNumero.Focused Or
                    edtString.Focused Or edtValor.Focused) Then
               Begin

                 If blnSempreRelerBanco Then
                   fAbreConsulta(True)
                 Else

                 Begin
                   cdsConsulta.Filter := fGetFilter;
                   cdsConsulta.Filtered := Not fEmptyStr(cdsConsulta.Filter);
                 End;

                 blnMudarFoco := False;
                 pSetFocus(pnlPesquisa);
                 dbgConsulta.Refresh;
                 Key := 0;
               End Else
               Begin
                 If blnFindNextOutros And (ActiveControl Is TRadioButton) Then
                   SelectNext(ActiveControl, True, True);
                    
                 inherited;
               End;
               
    VK_ESCAPE: Begin
                 If cdsConsulta.State in [dsInsert, dsEdit] Then
                   cdsConsulta.Post

                 Else If pnlPesquisa.Visible Then
                 Begin
                   pLimpaPesquisa;
                   pRefresh;
                   pSetFocus(dbgConsulta);

                   pAcaoAbort;

                   abort;
                 End

                 Else If pnlHeader.Visible And
                        (ActiveControl <> Nil) And
                        (Not fEstaNoHeader) And
                        (fGetActiveControl <> Nil) Then
                 Begin
                   pSetFocus(fGetActiveControl);
                 End

                 Else inherited;
               End;
    Else       inherited;
  End;

  If blnTemSelecao And cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    If  (((Key In [VK_UP,VK_DOWN]) And (ssShift In Shift)) Or
         ((Key = VK_RETURN) And blnSelecionaComEnter) Or
         ((Key = VK_SPACE) And blnSelecionaComEspaco)) And
        (dbgConsulta.Focused) And
        (cdsConsulta.RecordCount > 0) Then
      pAddListaQuery;

    If (Key in [VK_RETURN, VK_SPACE]) Then
      dbgConsulta.Refresh;
  End;
end;

procedure TfrmPaiOrdena.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;
  pProximaOrdenacao;
end;

procedure TfrmPaiOrdena.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pAbrePesquisa;
end;

procedure TfrmPaiOrdena.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;


procedure TfrmPaiOrdena.FormCreate(Sender: TObject);
begin
  inherited;

  intDigDec              := 2;
  qryConsulta.Connection := frmModulo.Database;
  stlListSelecao := TStringList.Create;
  stlListSelecao.Clear;
  lflLastField.intIndCol := -1;
  blnTemSelecao          := TRUE;
  blnTemMarcacao         := False;
  blnSelecionaComEnter   := TRUE;
  blnTemPesquisa         := TRUE;
  blnSempreRelerBanco    := TRUE;
  blnQuoteLista          := TRUE;
  strCampoLista          := 'AUTOINCREM';
  intCorSelecao          := clAqua;
  blnSelecionaComEspaco  := False;
  blnPodeIncluir         := FALSE;
  blnOrdemDesc           := False;
  blnFindNextOutros      := False;
end;

procedure TfrmPaiOrdena.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If (blnTemSelecao Or (stlListSelecao.Count > 0)) And fInLista Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := intCorSelecao;
      End;

    End;
  End;

  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmPaiOrdena.dbgConsultaTitleClick(Column: TColumn);
begin
  inherited;
  pnlPesquisa.Visible := false;

  If Not cdsConsulta.IsEmpty Then
  With lflLastField Do
  Begin
    If Column.Field.FieldKind <> fkLookup Then //OCORRE ERROS NOS CAMPOS LOOKUP
    Begin
      intIndCol := Column.Index;
      ftyTipCam := Column.Field.DataType;
      strNomCam := Column.Field.FieldName;
      strNomCol := Column.Title.Caption;
    End
    Else Exit;
  End;

  If blnSempreRelerBanco Then
    fAbreConsulta(False)
  Else
  Begin
    pSetFilterDefault;
    pOrdenaClient;
  End;

  pRefresh;  
end;

procedure TfrmPaiOrdena.pAcaoAdd;
Begin

End;

procedure TfrmPaiOrdena.pAcaoDel;
Begin

End;

procedure TfrmPaiOrdena.pAddListaQuery;
var
  strAuto  : String;
  intIndex : integer;
begin {AddListaQuery}
  If (blnTemSelecao Or blnTemMarcacao) And cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    If blnQuoteLista Then
      strAuto  := '''' + fRetChaveLista + ''''
    Else
      strAuto  := fRetChaveLista;

    intIndex := stlListSelecao.IndexOf(strAuto);
    If intIndex > -1 then
    Begin
      stlListSelecao.Delete(intIndex);
      pAcaoDel;
    End
    Else
    Begin
      stlListSelecao.Add(strAuto);
      pAcaoAdd;
    End;
  End;
end; {AddListaQuery}

procedure TfrmPaiOrdena.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  pAddListaQuery;
  dbgConsulta.Refresh;
end;

function TfrmPaiOrdena.fInLista: Boolean;
begin
  If blnQuoteLista Then
    Result := (stlListselecao.IndexOf('''' + fRetChaveLista + '''') > -1) Or
              (stlListselecao.IndexOf(fRetChaveLista) > -1)
  Else
    Result := stlListselecao.IndexOf(fRetChaveLista) > -1;

end;

procedure TfrmPaiOrdena.dbgConsultaDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If (blnTemSelecao Or (stlListSelecao.Count > 0)) And fInLista Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := intCorSelecao;
      End;

    End;
  End;
  dbgConsulta.DefaultDrawDataCell(Rect,Field,State);
end;

procedure TfrmPaiOrdena.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(stlListSelecao) Then
  Begin
    stlListSelecao.Clear;
    FreeAndNil(stlListSelecao);
  End;
end;

function TfrmPaiOrdena.fGetAliasField(strCampo: String): String;
Begin
  Result := strCampo;
End;

procedure TfrmPaiOrdena.cdsConsultaAfterInsert(DataSet: TDataSet);
begin
  inherited;
  If (Not blnPodeIncluir) And (cdsConsulta.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmPaiOrdena.FormShow(Sender: TObject);
begin
  inherited;
  btnPesquisar.Visible := blnTemPesquisa;
  btnMudaOrdem.Visible := blnTemPesquisa;
end;

procedure TfrmPaiOrdena.pLimpaEventoEdits;
Begin
  edtData.OnKeyDown := Nil;
  edtNumero.OnKeyDown := Nil;
  edtString.OnKeyDown := Nil;
  edtValor.OnKeyDown := Nil;
End;  

procedure TfrmPaiOrdena.pRefresh;
begin
  If blnSempreRelerBanco Then
    fAbreConsulta(False)
  Else
  Begin
    If cdsConsulta.Filtered Then
      pSetFilterDefault;
    pOrdenaClient;
  End;
end;

procedure TfrmPaiOrdena.pAcaoAbort;
Begin

End;

Procedure TfrmPaiOrdena.pOrdenaClient;
Begin
  cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
End;

Procedure TfrmPaiOrdena.pMarcaTodos;
Begin
  stlListSelecao.Clear;

  With cdsConsulta Do
  Begin

    DisableControls;
    First;

    While Not Eof Do
    Begin
      pAddListaQuery;
      Next;
    End;

    EnableControls;

  End;

  dbgConsulta.Repaint;
End;

Procedure TfrmPaiOrdena.pDesmarcaTodos;
Begin
  stlListSelecao.Clear;
  dbgConsulta.Refresh;
End;

Function TfrmPaiOrdena.fRetChaveLista: String;
Begin
  Result := cdsConsulta.Fieldbyname(strCampoLista).AsString;
End;

Function TfrmPaiOrdena.fGetNomePesquisa: String;
Begin
  Result := lflLastField.strNomCol + ':';
End;

end.



