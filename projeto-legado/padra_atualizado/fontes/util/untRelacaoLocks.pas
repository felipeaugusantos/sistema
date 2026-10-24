{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q-,R-,S-,T-,U-,V+,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
unit untRelacaoLocks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  Uni, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelacaoLocks = class(TfrmPai)
    pnlMensagem: TPanel;
    cxDadosDBTableView1: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    colDtaLck: TcxGridDBColumn;
    colHraLck: TcxGridDBColumn;
    colCodOpe: TcxGridDBColumn;
    colCon_Id: TcxGridDBColumn;
    colNum_Ip: TcxGridDBColumn;
    colChaAce: TcxGridDBColumn;
    btnLiberar: TBitBtnLocked;
    btnRefresh: TBitBtnLocked;
    colSelecionado: TcxGridDBColumn;
    lblMensagem: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxDadosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLiberarClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxDadosDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxDadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    blnLiberado: Boolean;
    procedure pSelecionaRegistro;
    function fRegistrosSelecionados: Integer;
    function fLiberarRegistro(strNum_IP, strCon_ID, strChaAce, strCodOpe: String; intTentat: Integer; dtaDtaLck, dtaHraLck: TDateTime): Boolean;
    procedure pLiberarRegistrosSelecionador;
    { Private declarations }
  public
    { Public declarations }
    blnPerRem: Boolean;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    pvdDados: TUniDataSetProvider;

    function fCarregaLocks: Boolean;
  end;

implementation

uses untFuncoesSimples, untModulo, untGravando;

{$R *.dfm}

procedure TfrmRelacaoLocks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(dtsDados);
  FreeAndNil(cdsDados);
  FreeAndNil(pvdDados);
end;

procedure TfrmRelacaoLocks.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TUniClientDataSet.Create(Self);
  pvdDados := TUniDataSetProvider.Create(Self);
  dtsDados := fCriaDataSource(cdsDados);

  cxDadosDBTableView1.DataController.DataSource := dtsDados;
end;

procedure TfrmRelacaoLocks.FormShow(Sender: TObject);
begin
  inherited;

  If blnPerRem Then
  Begin
    pnlMensagem.Visible := False;
    btnLiberar.Visible  := True;
    btnRefresh.Visible  := True;
  End
  Else
  Begin
    pnlMensagem.Visible := True;
    btnLiberar.Visible  := False;
    btnRefresh.Visible  := False;
  End;

  pSetFocus(cxDados);

end;

function TfrmRelacaoLocks.fRegistrosSelecionados: Integer;
var
  LRecno: Integer;
begin
  Result := 0;

  LRecno := cdsDados.recno;
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While not cdsDados.eof Do
    Begin
      If cdsDados.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        inc(Result);
      End;

      cdsDados.Next;
    End;
  Finally
    cdsDados.Recno := LRecno;
    cdsDados.EnableControls;
  End;

end;

function TfrmRelacaoLocks.fLiberarRegistro(strNum_IP, strCon_ID, strChaAce, strCodOpe: String; intTentat: Integer; dtaDtaLck, dtaHraLck: TDateTime): Boolean;
begin
  Result := fLock_Unlock(Copy(strChaAce, Length(frmModulo.GetCurrentConnection.Database + '.') + 1, Length(strChaAce)),
                         False, False, True, strCon_ID, True, '', True);

  If Result Then
    pGravaLogLck(strNum_IP, strCon_ID, strChaAce, strCodOpe, intTentat, dtaDtaLck, dtaHraLck);
end;

procedure TfrmRelacaoLocks.pLiberarRegistrosSelecionador;
begin
  blnLiberado := True;

  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While not cdsDados.eof Do
    Begin
      If cdsDados.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        blnLiberado := fLiberarRegistro(cdsDados.FieldByName('LCK_NUM_IP').AsString,
                                        cdsDados.FieldByName('LCK_CON_ID').AsString,
                                        cdsDados.FieldByName('LCK_CHAACE').AsString,
                                        cdsDados.FieldByName('LCK_CODOPE').AsString,
                                        cdsDados.FieldByName('LCK_TENTAT').AsInteger,
                                        cdsDados.FieldByName('LCK_DTALCK').AsDateTime,
                                        cdsDados.FieldByName('LCK_HRALCK').AsDateTime);

        If not blnLiberado Then
          Break;
      End;

      cdsDados.Next;
    End;

  Finally
    cdsDados.EnableControls;
  End;
end;

procedure TfrmRelacaoLocks.btnLiberarClick(Sender: TObject);
begin
  inherited;

  If Not btnLiberar.Visible Then
    Exit;

  If cdsDados.RecordCount <= 0 Then
  Begin
    pMensagemOk('Nenhum registro selecionado para liberação!');
    Exit;
  End;

  If fMensagem('','Deseja realmente liberar este(s) registro(s)?', ['','']) = 1 Then
  Begin
    blnLiberado := True;

    If fRegistrosSelecionados > 0 Then
      TfrmGravando.fExecutarModalA(pLiberarRegistrosSelecionador, 'Processando . . .', '')
    Else
      blnLiberado := fLiberarRegistro(cdsDados.FieldByName('LCK_NUM_IP').AsString,
                                      cdsDados.FieldByName('LCK_CON_ID').AsString,
                                      cdsDados.FieldByName('LCK_CHAACE').AsString,
                                      cdsDados.FieldByName('LCK_CODOPE').AsString,
                                      cdsDados.FieldByName('LCK_TENTAT').AsInteger,
                                      cdsDados.FieldByName('LCK_DTALCK').AsDateTime,
                                      cdsDados.FieldByName('LCK_HRALCK').AsDateTime);

    If blnLiberado Then
    Begin
      fMensagem('','Registro(s) liberado(s) com sucesso!',['&OK']);
      btnRefresh.Click;
    End
    Else
      fMensagem('','Falha ao liberar registro!',['&OK']);

  End;

end;

procedure TfrmRelacaoLocks.btnRefreshClick(Sender: TObject);
begin
  inherited;

  If Not btnRefresh.Visible Then
    Exit;

  fCarregaLocks;

end;

procedure TfrmRelacaoLocks.cxDadosDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaRegistro;
end;

procedure TfrmRelacaoLocks.cxDadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colSelecionado.Index]) = 'S' Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clLime
    Else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color  := clBlue;
    end;
  End;
end;

procedure TfrmRelacaoLocks.cxDadosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_F4    : btnLiberar.Click;
    VK_F5    : btnRefresh.Click;
    VK_Return: pSelecionaRegistro;
  End;

end;

procedure TfrmRelacaoLocks.pSelecionaRegistro;
begin
  cdsDados.Edit;
  cdsDados.FieldByName('SELECIONADO').AsString := IIF(cdsDados.FieldByName('SELECIONADO').AsString = 'N', 'S', 'N');
  cdsDados.Post;
end;

function TfrmRelacaoLocks.fCarregaLocks: Boolean;
  Var
    qryDados: TUniQuery;
begin
  Result := False;

  Try
    qryDados := fCriaQuery(Self);
    pvdDados.DataSet := qryDados;
    cdsDados.SetProvider(pvdDados);

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT "N" AS SELECIONADO, LCKATC.* FROM LCKATC WHERE ');
      SQL.Add('  NOT (LCK_CHAACE LIKE "%PAF\_%" OR LCK_CHAACE LIKE "%.IF\_%") ');

      If Not blnPerRem Then
      Begin
        SQL.Add(' AND LCK_CODOPE = :CODOPE');
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      End;

      cdsDados.Close;
      qryDados.Open;

      If Assigned(pvdDados.DataSet) Then
        pSetaClient(pvdDados.DataSet);

      cdsDados.SetProvider(pvdDados);
      cdsDados.Open;

      If Not cdsDados.IsEmpty Then
        Result := True;
    End;
  Except
    pMensagensErro('','');
  End;
  FreeAndNil(qryDados);
end;

end.
