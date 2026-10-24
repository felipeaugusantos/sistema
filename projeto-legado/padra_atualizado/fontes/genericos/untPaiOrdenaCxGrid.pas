unit untPaiOrdenaCxGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, Menus, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet,
  UniDataSetProvider, Uni, Grids, DBGridCitel, DBGrids, EditFocus, Mask, MaskEditFocus, StrUtils,
  AppEvnts, BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass, untModulo,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftLargeInt,ftWord,ftFloat];

type
  TLastField = Record
    intIndCol : integer;
    ftyTipCam : TFieldType;
    strNomCam,
    strNomCol : String;
  End;

  TfrmPaiOrdenaCxGrid = class(TfrmPaiEdit)
    pnlHeader: TPanel;
    pnlTail: TPanel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    pnlPesquisa: TPanel;
    dbgConsultaDados: TcxGridDBTableViewCitel;
    dbgConsultaNivel: TcxGridLevel;
    dbgConsulta: TcxGridCitel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDadosDblClick(Sender: TObject);
  private
    { Private declarations }

    Function fEstaNoHeader: Boolean;

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

    function fAsDate(strCampo, strValor: String): String;
    function fRetOperador(ftyTipCam : TFieldType): String;

    Procedure pSetColunaVisivel(strNomCam: String; blnVisivel: Boolean);

  protected
    lflLastField : TLastField;

    function fGetSql(blnLike: Boolean): String; Virtual;
    function fSetParametros: Boolean; Virtual;
    function fInLista: Boolean; Virtual;
    function fGetActiveControl: TWinControl; Virtual;
    function fGetAliasField(strCampo: String): String; Virtual;
    Function fGetNomePesquisa: String; Virtual;
    Function fRetChaveLista: String; Virtual;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; Virtual;

    Procedure pSetFilterDefault; Virtual;
    procedure pAddListaQuery; Virtual;
    procedure pAcaoAdd; Virtual;
    procedure pAcaoDel; Virtual;
    procedure pAcaoAbort; Virtual;
    procedure pRefresh; virtual;
    Procedure pOrdenaClient; Virtual;
 end;

var
  frmPaiOrdenaCxGrid: TfrmPaiOrdenaCxGrid;

implementation

uses untFuncoesSimples, System.UITypes;

{$R *.dfm}

Procedure TfrmPaiOrdenaCxGrid.pSetFilterDefault;
Begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
End;

Procedure TfrmPaiOrdenaCxGrid.pSetColunaVisivel(strNomCam: String; blnVisivel: Boolean);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To dbgConsultaDados.ColumnCount - 1 Do
    If SameText(dbgConsultaDados.Columns[intContador].DataBinding.FieldName, strNomCam) Then
    Begin
      dbgConsultaDados.Columns[intContador].Visible := blnVisivel;
      Exit;
    End;
End;

function TfrmPaiOrdenaCxGrid.fSetParametros: Boolean;
Begin
  Result := TRUE;
End;

procedure TfrmPaiOrdenaCxGrid.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

function TfrmPaiOrdenaCxGrid.fGetActiveControl: TWinControl;
Begin
  Result := NIL;
End;

{******************************************************}
{*  RETORNA O OPERADOR DE ACORDO COM O TIPO DE DADO   *}
{***************************************************LA*}
function TfrmPaiOrdenaCxGrid.fRetOperador(ftyTipCam : TFieldType): String;
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
function TfrmPaiOrdenaCxGrid.fAsDate(strCampo, strValor: String): String;
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

function TfrmPaiOrdenaCxGrid.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
End;

Function TfrmPaiOrdenaCxGrid.fEstaNoHeader: Boolean;
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

procedure TfrmPaiOrdenaCxGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN:Begin
                 If blnFindNextOutros And (ActiveControl Is TRadioButton) Then
                   SelectNext(ActiveControl, True, True);

                 inherited;
               End;

    VK_ESCAPE: Begin
                 If cdsConsulta.State in [dsInsert, dsEdit] Then
                   cdsConsulta.Post

                 Else If pnlPesquisa.Visible Then
                 Begin
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
        (dbgConsultaDados.Focused) And
        (cdsConsulta.RecordCount > 0) Then
      pAddListaQuery;

    If ((Key = VK_RETURN) And blnSelecionaComEnter) Or
       ((Key = VK_SPACE) And blnSelecionaComEspaco) Then
      dbgConsulta.Refresh;
  End;
end;

procedure TfrmPaiOrdenaCxGrid.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;

procedure TfrmPaiOrdenaCxGrid.FormCreate(Sender: TObject);
begin
  inherited;

  intDigDec              := 2;
  qryConsulta.Connection := frmModulo.GetCurrentConnection;
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

procedure TfrmPaiOrdenaCxGrid.FormDestroy(Sender: TObject);
begin
  If Assigned(stlListSelecao) Then
  Begin
    stlListSelecao.Clear;
    FreeAndNil(stlListSelecao);
  End;

  inherited;
end;

procedure TfrmPaiOrdenaCxGrid.pAcaoAdd;
Begin

End;

procedure TfrmPaiOrdenaCxGrid.pAcaoDel;
Begin

End;

procedure TfrmPaiOrdenaCxGrid.pAddListaQuery;
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

procedure TfrmPaiOrdenaCxGrid.dbgConsultaDadosDblClick(Sender: TObject);
begin
  inherited;
  pAddListaQuery;
  dbgConsulta.Refresh;
end;

function TfrmPaiOrdenaCxGrid.fInLista: Boolean;
begin
  If blnQuoteLista Then
    Result := (stlListselecao.IndexOf('''' + fRetChaveLista + '''') > -1) Or
              (stlListselecao.IndexOf(fRetChaveLista) > -1)
  Else
    Result := stlListselecao.IndexOf(fRetChaveLista) > -1;

end;

function TfrmPaiOrdenaCxGrid.fGetAliasField(strCampo: String): String;
Begin
  Result := strCampo;
End;

procedure TfrmPaiOrdenaCxGrid.cdsConsultaAfterInsert(DataSet: TDataSet);
begin
  inherited;
  If (Not blnPodeIncluir) And (cdsConsulta.Tag = 0) Then
    DataSet.Cancel;
end;


procedure TfrmPaiOrdenaCxGrid.pRefresh;
begin
  If Not(blnSempreRelerBanco) Then
  Begin
    If cdsConsulta.Filtered Then
      pSetFilterDefault;
    pOrdenaClient;
  End;
end;

procedure TfrmPaiOrdenaCxGrid.pAcaoAbort;
Begin

End;

Procedure TfrmPaiOrdenaCxGrid.pOrdenaClient;
Begin
  cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
End;

Procedure TfrmPaiOrdenaCxGrid.pMarcaTodos;
Begin
  If Not cdsConsulta.Active Then
    Exit;

  stlListSelecao.Clear;

  cdsConsulta.DisableControls;
  cdsConsulta.First;

  While Not cdsConsulta.Eof Do
  Begin
    pAddListaQuery;
    cdsConsulta.Next;
  End;

  cdsConsulta.EnableControls;

  dbgConsulta.Repaint;
End;

Procedure TfrmPaiOrdenaCxGrid.pDesmarcaTodos;
Begin
  stlListSelecao.Clear;
  dbgConsulta.Refresh;
End;

Function TfrmPaiOrdenaCxGrid.fRetChaveLista: String;
Begin
  Result := cdsConsulta.Fieldbyname(strCampoLista).AsString;
End;

Function TfrmPaiOrdenaCxGrid.fGetNomePesquisa: String;
Begin
  Result := lflLastField.strNomCol + ':';
End;

function TfrmPaiOrdenaCxGrid.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Try
    qryConsulta.Close;
    cdsConsulta.Close;
    qryConsulta.Sql.Clear;

    qryConsulta.Sql.Add(fGetSql(blnLike));

    If Not fSetParametros Then
    Begin
      Result := False;
      Exit;
    End;

    qryConsulta.Open;

    If Assigned(dspConsulta.DataSet) Then
      pSetaClient(dspConsulta.DataSet);

    cdsConsulta.Open;

    pSetFilterDefault;


    If (Not pnlPesquisa.Visible) And dbgConsulta.CanFocus Then
      pSetFocus(dbgConsulta);

    Result := True;

    blnMudarFoco := FALSE;
  Except

    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmPaiOrdena.fAbreConsulta]');
      Result := False;
    End;

  End;
End;

end.




