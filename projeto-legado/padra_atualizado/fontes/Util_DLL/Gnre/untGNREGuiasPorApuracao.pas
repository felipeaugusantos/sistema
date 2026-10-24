unit untGNREGuiasPorApuracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.DateUtils, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxCalendar, cxTextEdit, cxCurrencyEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.ComCtrls, Vcl.Mask, MaskEditFocus, cxContainer, cxMemo, cxDBEdit, Datasnap.DBClient, UniClientDataSet, MemDS,
  DBAccess, Uni, Datasnap.Provider, UniDataSetProvider, cxMaskEdit, cxDropDownEdit, cxImageComboBox, untTLock,
  System.Types, System.Math, untCadPag, untTCadPag, untTCadPagRepository, untLogCtp, untGNREWebService,
  System.ImageList, Vcl.ImgList, cxImageList;

type
  TfrmGNREGuiasPorApuracao = class(TfrmPai)
    Panel1: TPanel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBView: TcxGridDBTableView;
    dbgConsultaDBViewAPU_ESTADO: TcxGridDBColumn;
    dbgConsultaDBViewAPU_VLRPRI: TcxGridDBColumn;
    dbgConsultalevel: TcxGridLevel;
    pgbProgresso: TProgressBar;
    rdgSituacao: TRadioGroup;
    btnConsultar: TBitBtnLocked;
    btnGerarRegistros: TBitBtnLocked;
    dtsConsulta: TDataSource;
    dspConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsConsulta: TUniClientDataSet;
    pnlMsgWS: TPanel;
    GroupST: TGroupBox;
    dbmST: TcxDBMemo;
    GroupFCP: TGroupBox;
    dbmFCP: TcxDBMemo;
    GroupDIFAL: TGroupBox;
    dbmDIFAL: TcxDBMemo;
    Label4: TLabel;
    dbgConsultaDBViewAUTOINCREM: TcxGridDBColumn;
    dbgConsultaDBViewAPU_TIPREC: TcxGridDBColumn;
    dbgConsultaDBViewAPU_MESGNR: TcxGridDBColumn;
    dbgConsultaDBViewAPU_ANOGNR: TcxGridDBColumn;
    dbgConsultaDBViewAPU_DTACAD: TcxGridDBColumn;
    dbgConsultaDBViewAPU_HORCAD: TcxGridDBColumn;
    dbgConsultaDBViewAPU_DTAVEN: TcxGridDBColumn;
    dbgConsultaDBViewAPU_DTAPAG: TcxGridDBColumn;
    dbgConsultaDBViewAPU_VLRFCP: TcxGridDBColumn;
    dbgConsultaDBViewAPU_GNREOK: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnImprimirGuias: TBitBtnLocked;
    btnGerarGuias: TBitBtnLocked;
    btnExcluirRegistro: TBitBtnLocked;
    dbgConsultaDBViewAPU_GNRREJ: TcxGridDBColumn;
    dbgConsultaDBViewSELECIONADO: TcxGridDBColumn;
    grpDocumento: TGroupBox;
    icbMes: TcxImageComboBox;
    cbxAno: TcxComboBox;
    btnConfiguracoes: TBitBtnLocked;
    cxImageList: TcxImageList;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyle17: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    cxStyle20: TcxStyle;
    cxStyle21: TcxStyle;
    cxStyle22: TcxStyle;
    cxStyle23: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle24: TcxStyle;
    cxStyle25: TcxStyle;
    cxStyle26: TcxStyle;
    cxStyle27: TcxStyle;
    cxStyle28: TcxStyle;
    cxStyle29: TcxStyle;
    cxStyle30: TcxStyle;
    cxStyleSelecao: TcxStyle;
    cxStyle32: TcxStyle;
    cxStyle33: TcxStyle;
    cxStyle34: TcxStyle;
    cxStyle35: TcxStyle;
    cxStyle36: TcxStyle;
    cxStyle37: TcxStyle;
    cxStyle38: TcxStyle;
    cxStyleZebrado: TcxStyle;
    cxStyle40: TcxStyle;
    cxStyle41: TcxStyle;
    cxStyle42: TcxStyle;
    cxStyle43: TcxStyle;
    cxStyle44: TcxStyle;
    cxStyle45: TcxStyle;
    cxStyle46: TcxStyle;
    cxStyle47: TcxStyle;
    GridTableViewStyleSheetUserFormat3: TcxGridTableViewStyleSheet;
    btnEditarRegistro: TBitBtnLocked;
    procedure btnConsultarClick(Sender: TObject);
    procedure btnGerarRegistrosClick(Sender: TObject);
    procedure btnExcluirRegistroClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure dbgConsultaDBViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dbgConsultaDBViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaDBViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnGerarGuiasClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnImprimirGuiasClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cbxAnoPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnEditarRegistroClick(Sender: TObject);
  private
    FMesGnr: String;
    FAnoGnr: String;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FDtaVen: TDateTime;
    FDtaPag: TDateTime;
    FOpcao: Integer;
    FObjLock: TLock;
    FGnreSt,
    FGnreDf,
    FGnreFc,
    FGnrePagarSt,
    FGnrePagarDf,
    FGnrePagarFc,
    FGnreForSt,
    FGnreForDf,
    FGnreForFc,
    FGnrePorSt,
    FGnrePorDf,
    FGnrePorFc,
    FGnreEvento: String;
    FToleranciaBoleto: Double;
    FImpressora: String;
    FSemaforoConfirma: Integer;
    function fGetSql: String;
    procedure pConsultar;
    function fRetornaUFsDeApuracao: String;
    function fGetSqlApuracao: String;
    function fGetSqlTemporaria: String;
    procedure pPreparaApuracao;
    function fReceitaUtilizadaNaUF(AUF: String; AOpcao: Integer): Boolean;
    function fReceita(AOpcao: Integer): String;
    function fTipoReceita(AOpcao: Integer): String;
    function fCarregaConfiguracoes : Boolean;
    function fExisteApuracao(AOpcao: Integer; AEstado, ACodEmp, AMesGnr, AAnoGnr: String): Boolean;
    procedure pGravaArquivos(AOpcao: Integer; ACodEmp, AMesGnr, AAnoGnr: String; ADtaVen, ADtaPag: TDateTime; ADataSet: TUniQuery);
    procedure pApagaTabelaTemporaria;
    procedure pCriaTabelaTemporaria(ADtaIni, ADtaFin: TDateTime);
    procedure pVinculaDocumentos(AOpcao: Integer; AAutInc, AEstado: String);
    procedure pExcluirApuracao;
    procedure pDesmarcarTodos;
    procedure pMarcarTodos;
    function fValidaSelecionado(AExibirMensagem: Boolean): Boolean;
    procedure pSelecionaDocumento;
    procedure pDesmarcaDocumento;
    procedure pMarcaDocumento;
    procedure pLimpaFiltros;
    function fValidaDocumento(AExibirMensagem:Boolean=True): Boolean;
    function fValidaEstadosSuportados(AExibirMensagem: Boolean): Boolean;
    function fDocumentosSelecionados: Integer;
    function fGnreEnviar(var WSGnre: TWSGnre): Boolean;
    procedure pGnreConfigurar(var WSGnre: TWSGnre);
    procedure pGnrePreencherGuia(var WSGnre: TWSGnre);
    procedure pGnreRegistraSituacaoDaGuia(AMensagem: String);
    procedure pGnreRejeicao(ATeveRejeicao: Boolean);
    function fGnreGerarFinanceiro(ACodigoDaReceita, AChaveDeApuracao, AConvenio, ANumeroDeControle, ACodBarra, ALinhaDigitavel, AQrCode: String; AVlrMulta, AVlrJuros, AVlrDuplicata: Double ): Boolean;
    function fExisteFinanceiro(AChaveDeApuracao, ACodigoDaReceita: String): Boolean;
    function fExisteFinanceiroBaixado(AChaveDeApuracao: String): Boolean; overload;
    function fExisteFinanceiroBaixado(AChaveDeApuracao, ACodigoDaReceita: String): Boolean; overload;
    procedure pGravaLogCadPag(ANumDup, AParcel: String; ASeqBai: Integer; ACodEmp, ACodFor, ASerie_: String);
    procedure pGnreApagaFinanceiro(AChaveDeApuracao: String);
    procedure pImprimirGuias;
    procedure pCarregaDocumentosParaImpressao;
    procedure pGerarGuias;
    procedure pGeraApuracao;
    function fValidaExisteFinanceiroBaixado: Boolean;
    function fValidaCapicom: Boolean;
    function fValidaCertificadoSerial: Boolean;
    function fValidaOpenSSLCertificadoPFX: Boolean;
    procedure pGnreImprimirGuias;
    function fGuiaComDatasOK: Boolean;
    procedure pHabilitaImpressao;
    { Private declarations }
  public
    FCertificadoPFX: String;
    FCertificadoPEM: String;
    FCertificadoKEY: String;
    FCertificadoSenha: String;
    FSerialCertificado: String;
    { Public declarations }
  end;

var
  frmGNREGuiasPorApuracao: TfrmGNREGuiasPorApuracao;

implementation

uses untFuncoesSimples, untTypesSistema, untGravando, untGNREModulo, untGNREGuiasPorApuracaoDatas, untGNREGuiasPorApuracaoDados, untGNRERegrasDePreenchimento, untConsultas;

const
  UF       = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_SP_TO_';
  UF_ST    = 'AC_AL_AM_AP_BA_CE_DF_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_TO_';
  UF_FCP   = 'AL_AM_BA_CE_DF_GO_MA_MG_MS_MT_PB_PE_PI_RN_RS_SE_TO_';
  UF_DIFAL = 'AC_AL_AM_AP_BA_CE_DF_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_TO_';

{$R *.dfm}

function TfrmGNREGuiasPorApuracao.fTipoReceita(AOpcao: Integer): String;
begin
  case AOpcao of
    0: Result := 'ST';
    1: Result := 'FCP';
    2: Result := 'DIFAL';
  end;
end;

function TfrmGNREGuiasPorApuracao.fReceita(AOpcao: Integer):String;
begin
  case AOpcao of
    0: Result := fStrZero( varToStr(fCfgSis('GNRAST', varString)), 6);
    1: Result := fStrZero( varToStr(fCfgSis('GNRAFC', varString)), 6);
    2: Result := fStrZero( varToStr(fCfgSis('GNRADF', varString)), 6);
  end;
end;

function TfrmGNREGuiasPorApuracao.fCarregaConfiguracoes : Boolean;
Begin
  Result := False;

  Try
    FGnreSt := fCfgSis('GNRAST');
    FGnreDf := fCfgSis('GNRADF');
    FGnreFc := fCfgSis('GNRAFC');

    FGnrePagarSt := fCfgSis('CTAPST');
    FGnrePagarDf := fCfgSis('CTAPDF');
    FGnrePagarFc := fCfgSis('CTAPFC');

    FGnreForSt := fCfgSis('FORGST');
    FGnreForDf := fCfgSis('FORGDF');
    FGnreForFc := fCfgSis('FORGFC');

    FGnrePorSt := fCfgSis('GPORST');
    FGnrePorDf := fCfgSis('GPORDF');
    FGnrePorFc := fCfgSis('GPORFC');

    FGnreEvento := fCfgSis('GPGEVE');

    FToleranciaBoleto := fCfgSis('TOLGNR', varDouble);

    FImpressora := fCfgSis('GNRIMP');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGNREGuiasPorApuracao.fCarregaConfiguracoes]');
    End;
  End;
End;

function TfrmGNREGuiasPorApuracao.fGetSql: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   "N" AS SELECIONADO, ';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   APU_CODEMP, ';
  Result := Result + '   APU_ESTADO, ';
  Result := Result + '   APU_I_E_S_, ';
  Result := Result + '   APU_TIPREC, ';
  Result := Result + '   APU_CODREC, ';
  Result := Result + '   APU_MESGNR, ';
  Result := Result + '   APU_ANOGNR, ';
  Result := Result + '   APU_DTACAD, ';
  Result := Result + '   APU_HORCAD, ';
  Result := Result + '   APU_DTAVEN, ';
  Result := Result + '   APU_DTAPAG, ';
  Result := Result + '   APU_VLRPRI, ';
  Result := Result + '   APU_VLRFCP, ';
  Result := Result + '   APU_GNREOK, ';
  Result := Result + '   APU_GNRREJ, ';
  Result := Result + '   APU_ST_REJ, ';
  Result := Result + '   APU_DFLREJ, ';
  Result := Result + '   APU_FCPREJ  ';
  Result := Result + ' FROM APUGNR ';
  Result := Result + ' WHERE APU_MESGNR = :MESGNR ';
  Result := Result + '   AND APU_ANOGNR = :ANOGNR ';
  Result := Result + '   AND APU_GNREOK = :GNREOK ';
  Result := Result + ' ORDER BY APU_ESTADO ';
end;

procedure TfrmGNREGuiasPorApuracao.pConsultar;
begin
  FObjLock.pDestravarTodos;

  cdsConsulta.Close;

  qryConsulta.Close;
  qryConsulta.SQL.Text := fGetSql;
  qryConsulta.ParamByName('MESGNR').AsString := UpperCase(icbMes.Text);
  qryConsulta.ParamByName('ANOGNR').AsString := VarToStr(cbxAno.EditValue);
  qryConsulta.ParamByName('GNREOK').AsString := IIF(rdgSituacao.ItemIndex = 0, 'S','N');
  qryConsulta.Open;

  If Assigned(dspConsulta.DataSet) Then
    pSetaClient(dspConsulta.DataSet);

  cdsConsulta.Open;

  If qryConsulta.isEmpty Then
    pMensagemOk('Nenhum documento foi encontrado!')
  Else
    pSetFocus(dbgConsulta);
end;

procedure TfrmGNREGuiasPorApuracao.pExcluirApuracao;
var
  qryUpd: TUniQuery;
  qryAux: TUniQuery;
begin

  fStartTransaction;

  Try

    Try
      cdsConsulta.DisableControls;
      cdsConsulta.First;

      While not cdsConsulta.eof Do
      begin
        If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' then
        begin
          qryUpd := fCriaQuery;

          Try
            qryUpd.Close;
            qryUpd.SQL.Clear;
            qryUpd.SQL.Add('UPDATE AUXMOV SET AUX_APUGNR = NULL ');
            qryUpd.SQL.Add('WHERE AUX_APUGNR = :APUGNR ');
            qryUpd.ParamByName('APUGNR').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            qryUpd.ExecSQL;
          Finally
            FreeAndNil(qryUpd);
          End;

          qryUpd := fCriaQuery;

          Try
            qryUpd.Close;
            qryUpd.SQL.Clear;
            qryUpd.SQL.Add('UPDATE AUXNOT SET AUX_APUGNR = NULL ');
            qryUpd.SQL.Add('WHERE AUX_APUGNR = :APUGNR ');
            qryUpd.ParamByName('APUGNR').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            qryUpd.ExecSQL;
          Finally
            FreeAndNil(qryUpd);
          End;

          qryAux := fCriaQuery;

          Try
            qryAux.Close;
            qryAux.SQL.Text := 'DELETE FROM CADPAG WHERE CTP_APUGNR = :APUGNR ';
            qryAux.ParamByName('APUGNR').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            qryAux.ExecSQL;
          Finally
            FreeAndNil(qryAux);
          End;

          qryAux := fCriaQuery;

          Try
            qryAux.Close;
            qryAux.SQL.Text := 'DELETE FROM APUGNR WHERE AUTOINCREM = :AUTINC ';
            qryAux.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            qryAux.ExecSQL;
          Finally
            FreeAndNil(qryAux);
          End;

          FObjLock.fLock_Unlock('GNRE_APURACAO' + cdsConsulta.FieldByName('AUTOINCREM').AsString, False, False);
        end;

        cdsConsulta.Next;
      end;
    Finally
      If fInTransaction Then
        fCommit;

      cdsConsulta.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      If fInTransaction Then
        fRollBack;

      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[TfrmGNREGuiasPorApuracao.pExcluirApuracao]');
    End;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pLimpaFiltros;
begin
  FObjLock.pDestravarTodos;
  cdsConsulta.Close;
end;

procedure TfrmGNREGuiasPorApuracao.pMarcaDocumento;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('SELECIONADO').AsString := 'S';
  cdsConsulta.Post;
end;

procedure TfrmGNREGuiasPorApuracao.pDesmarcaDocumento;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';
  cdsConsulta.Post;
end;

procedure TfrmGNREGuiasPorApuracao.pSelecionaDocumento;
begin
  cdsConsulta.Edit;

  If cdsConsulta.FieldByName('SELECIONADO').AsString = 'N' Then
    cdsConsulta.FieldByName('SELECIONADO').AsString := 'S'
  Else
    cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';

  cdsConsulta.Post;
end;

function TfrmGNREGuiasPorApuracao.fValidaSelecionado(AExibirMensagem:Boolean):Boolean;
begin
  Result := True;

  If (cdsConsulta.FieldByName('SELECIONADO').AsString = 'S') Then
  Begin
    FObjLock.fLock_Unlock('GNRE_APURACAO' + cdsConsulta.fieldByName('AUTOINCREM').AsString, False, False);
  End
  Else
  Begin
    If Not FObjLock.fLock_Unlock('GNRE_APURACAO' + cdsConsulta.fieldByName('AUTOINCREM').AsString, True, False) Then
    Begin
      If AExibirMensagem Then
        fMensagem('', 'Esse Documento está sendo utilizado em outra estação por ' +
                      fGetHostLock('GNRE_APURACAO' + cdsConsulta.fieldByName('AUTOINCREM').AsString) + '!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmGNREGuiasPorApuracao.fDocumentosSelecionados: Integer;
var
  LRecno: Integer;
Begin
  Result := 0;

  LRecno := cdsConsulta.recno;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        inc(Result);
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Recno := LRecno;
    cdsConsulta.EnableControls;
  End;

End;

function TfrmGNREGuiasPorApuracao.fValidaEstadosSuportados(AExibirMensagem:Boolean):Boolean;
begin
  Result := False;

  Try
    If pos(cdsConsulta.FieldByName('APU_ESTADO').AsString, 'ES_SP_') > 0 Then
      Exit;

    Result := True;

  Finally
    If not Result And AExibirMensagem Then
      fMensagem('', 'Não é possível gerar guias de recolhimento para o documento selecionado.'+#13+
                    'Utilize o site da secretária da fazendo da UF selecionada.', ['&Ok']);
  End;

end;

procedure TfrmGNREGuiasPorApuracao.pHabilitaImpressao;
begin
  btnImprimirGuias.Enabled := (rdgSituacao.ItemIndex = 0);
end;

function TfrmGNREGuiasPorApuracao.fValidaDocumento(AExibirMensagem:Boolean=True):Boolean;
begin
  Result := False;

  If not fValidaEstadosSuportados(AExibirMensagem) Then
    Exit;

  If not fValidaSelecionado(AExibirMensagem) Then
    Exit;

  Result := True;
end;

procedure TfrmGNREGuiasPorApuracao.pMarcarTodos;
var
  LIndex   : Integer;
  LAutInc  : String;
  LContador: Integer;
begin
  Try
    cdsConsulta.DisableControls;
    For LContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
    begin
      LIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[LContador];
      LAutInc := dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewAUTOINCREM.Index];

      If pos(VarToStr(dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewAPU_ESTADO.Index]), 'ES_SP_') > 0 Then
        Continue;

      If cdsConsulta.Locate('AUTOINCREM', LAutInc, []) then
      begin
        If fValidaDocumento(False) Then
        begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('SELECIONADO').AsString := 'S';
          cdsConsulta.Post;
        end;
      end;

      If (LContador Mod 4 = 0) Then
        Application.ProcessMessages;
    end;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If not cdsConsulta.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pMarcarTodos, 'Marcando documentos . . .', '');
  End;
end;

procedure TfrmGNREGuiasPorApuracao.cbxAnoPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If fEmptyStr(DisplayValue) Then
    DisplayValue := '2024';
end;

procedure TfrmGNREGuiasPorApuracao.dbgConsultaDBViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If not cdsConsulta.isEmpty Then
  Begin
    If fValidaDocumento Then
      pSelecionaDocumento;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.dbgConsultaDBViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If not cdsConsulta.ControlsDisabled Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDBViewSELECIONADO.Index]) = 'S' Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Color := clLime
      Else
      begin
        ACanvas.Brush.Color := clHotLight;
        ACanvas.Font.Color  := clYellow;
      end;
    End
    Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDBViewAPU_GNRREJ.Index]) = 'S' Then
    Begin
      ACanvas.Brush.Color := clRed;
      ACanvas.Font.Color  := clWhite;
    End;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.dbgConsultaDBViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      If fValidaDocumento Then
        pSelecionaDocumento;
    End;
  End;

  If (Key = VK_DELETE) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      btnExcluirRegistro.Click;
    End;
  End;

  If (Shift=[ssShift]) and (Key = VK_DOWN) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      If fValidaDocumento Then
        pMarcaDocumento;
    End;
  End;

  If (Shift=[ssShift]) and (Key = VK_UP) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      pDesmarcaDocumento;

      FObjLock.fLock_Unlock('GNRE_APURACAO' + cdsConsulta.FieldByName('AUTOINCREM').AsString, False, False);
    End;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pDesmarcarTodos;
var
  LIndex   : Integer;
  LAutInc  : String;
  LContador: Integer;
begin
  Try
    cdsConsulta.DisableControls;
    For LContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
    begin
      LIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[LContador];
      LAutInc := dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewAUTOINCREM.Index];

      if cdsConsulta.Locate('AUTOINCREM', LAutInc, []) then
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';
        cdsConsulta.Post;

        FObjLock.fLock_Unlock('GNRE_APURACAO' + cdsConsulta.FieldByName('AUTOINCREM').AsString, False, False);
      end;

      If (LContador Mod 4 = 0) Then
        Application.ProcessMessages;
    end;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnDesmarcaTodosClick(Sender: TObject);
begin
  If not cdsConsulta.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pDesmarcarTodos, 'Desmarcando documentos . . .', '');
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnEditarRegistroClick(Sender: TObject);
var
  qryAux: TUniQuery;
  LContinua: Boolean;
  LDtaVen: TDateTime;
  LDtaPag: TDateTime;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (rdgSituacao.ItemIndex = 0) Then
    Exit;

  pCriarFormularios(TfrmGNREGuiasPorApuracaoDados, frmGNREGuiasPorApuracaoDados);
  Try
    frmGNREGuiasPorApuracaoDados.edtEstado.Text := cdsConsulta.FieldByName('APU_ESTADO').AsString;
    frmGNREGuiasPorApuracaoDados.edtTipRec.Text := cdsConsulta.FieldByName('APU_TIPREC').AsString;
    frmGNREGuiasPorApuracaoDados.mskDtaVen.Text := cdsConsulta.FieldByName('APU_DTAVEN').AsString;
    frmGNREGuiasPorApuracaoDados.mskDtaPag.Text := cdsConsulta.FieldByName('APU_DTAPAG').AsString;
    frmGNREGuiasPorApuracaoDados.ShowModal;

    LContinua := (frmGNREGuiasPorApuracaoDados.ModalResult = mrOk);

    LDtaVen := frmGNREGuiasPorApuracaoDados.FDtaVen;
    LDtaPag := frmGNREGuiasPorApuracaoDados.FDtaPag;

  Finally
    pFreeAndNil(frmGNREGuiasPorApuracaoDados);
  End;

  If not LContinua Then
    Exit;

  If not fDataValida(LDtaVen) Then
    Exit;

  If not fDataValida(LDtaPag) Then
    Exit;

  Try

    cdsConsulta.Edit;
    cdsConsulta.FieldByName('APU_DTAVEN').AsDateTime := LDtaVen;
    cdsConsulta.FieldByName('APU_DTAPAG').AsDateTime := LDtaPag;
    cdsConsulta.Post;

    qryAux := fCriaQuery;

    Try
      qryAux.Close;
      qryAux.SQL.Text := 'UPDATE APUGNR SET APU_DTAVEN = :DTAVEN, APU_DTAPAG = :DTAPAG WHERE AUTOINCREM = :AUTINC ';
      qryAux.ParamByName('AUTINC').AsString   := cdsConsulta.FieldByName('AUTOINCREM').AsString;
      qryAux.ParamByName('DTAVEN').AsDateTime := LDtaVen;
      qryAux.ParamByName('DTAPAG').AsDateTime := LDtaPag;
      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGNREGuiasPorApuracao.btnEditarRegistroClick]');
    End;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnExcluirRegistroClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (fDocumentosSelecionados = 0) Then
  Begin
    pMensagemOk('Nenhum documento foi selecionado!');
    Exit;
  End;

  If fValidaExisteFinanceiroBaixado Then
    Exit;

  If (fMensagem('', 'Deseja excluir os registros selecionados ?', ['&Sim', '&Não']) = 1) Then
  Begin
    TfrmGravando.fExecutarModalA(pExcluirApuracao, 'Excluindo documentos . . .', '');
    btnConsultar.Click;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnGerarRegistrosClick(Sender: TObject);
begin
  inherited;
  pPreparaApuracao;
end;

procedure TfrmGNREGuiasPorApuracao.btnImprimirGuiasClick(Sender: TObject);
begin
  If cdsConsulta.isEmpty Then
    Exit;

  If rdgSituacao.ItemIndex = 1 Then
    Exit;

  If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
  Begin
    pImprimirGuias;

    InterlockedDecrement(FSemaforoConfirma);
  End
  Else
    InterlockedDecrement(FSemaforoConfirma);

end;

procedure TfrmGNREGuiasPorApuracao.btnConfiguracoesClick(Sender: TObject);
begin
  pCriarFormularios(TfrmGNRERegrasDePreenchimento, frmGNRERegrasDePreenchimento);
  Try
    frmGNRERegrasDePreenchimento.FApuracao    := True;
    frmGNRERegrasDePreenchimento.FHomologacao := False;
    frmGNRERegrasDePreenchimento.ShowModal;
  Finally
    pFreeAndNil(frmGNRERegrasDePreenchimento);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnConsultarClick(Sender: TObject);
begin
  inherited;
  pLimpaFiltros;
  pHabilitaImpressao;

  TfrmGravando.fExecutarModalA(pConsultar, 'Carregando documentos . . .', '');
end;

function TfrmGNREGuiasPorApuracao.fRetornaUFsDeApuracao: String;
begin
  Result := fTransform(fCfgSis('GNRAUF'), 2);
end;

function TfrmGNREGuiasPorApuracao.fGetSqlApuracao: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   GER_ESTADO, ';
  Result := Result + '   EMP_INSSUB, ';
  Result := Result + '   SUM(VAL_ST) AS VAL_ST, ';
  Result := Result + '   SUM(VAL_FCP) AS VAL_FCP, ';
  Result := Result + '   SUM(VAL_FCP_ST) AS VAL_FCP_ST, ';
  Result := Result + '   SUM(VAL_DIFAL) AS VAL_DIFAL ';
  Result := Result + ' FROM TMP_APUGNR ';
  Result := Result + ' GROUP BY GER_ESTADO ';
end;

function TfrmGNREGuiasPorApuracao.fGetSqlTemporaria: String;
var
  LModelo: String;
  LVenda: String;
  LDevolucao: String;
Begin
  LModelo := '';
  LModelo := LModelo + '   SELECT ';
  LModelo := LModelo + '      "AUXMOV" AS TABELA, ';
  LModelo := LModelo + '      MOVGER.AUTOINCREM, ';
  LModelo := LModelo + '      MOVGER.GER_ESTADO, ';

  LModelo := LModelo + '      (SELECT EMP_INSSUB FROM EMPISB ';
  LModelo := LModelo + '       WHERE EMPISB.EMP_CODEMP = MOVGER.GER_CODEMP ';
  LModelo := LModelo + '         AND EMPISB.EMP_ESTADO = MOVGER.GER_ESTADO) AS EMP_INSSUB, ';

  LModelo := LModelo + '      IFNULL((SELECT SUM(DET_VALRET) FROM MOVDET ';
  LModelo := LModelo + '               WHERE MOVDET.DET_VALRET > 0 ';
  LModelo := LModelo + '                 AND MOVDET.DET_PROEMB <> "S" ';
  LModelo := LModelo + '                 AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), 0) AS VAL_ST, ';

  LModelo := LModelo + '      IFNULL((SELECT SUM(ICD_VALFCP) FROM MOVDET ';
  LModelo := LModelo + '               INNER JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
  LModelo := LModelo + '               WHERE MOVDET.DET_VALRET = 0 ';
  LModelo := LModelo + '                 AND MOVDET.DET_PROEMB <> "S" ';
  LModelo := LModelo + '                 AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), 0) AS VAL_FCP, ';

  LModelo := LModelo + '      IFNULL((SELECT SUM(DET_VFCPST) FROM MOVDET ';
  LModelo := LModelo + '               INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  LModelo := LModelo + '               WHERE MOVDET.DET_VALRET > 0 ';
  LModelo := LModelo + '                 AND MOVDET.DET_PROEMB <> "S" ';
  LModelo := LModelo + '                 AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), 0) AS VAL_FCP_ST, ';

  LModelo := LModelo + '      IFNULL((SELECT SUM(ICD_VALDES) FROM MOVDET ';
  LModelo := LModelo + '               INNER JOIN MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM ';
  LModelo := LModelo + '               WHERE MOVDET.DET_PROEMB <> "S" ';
  LModelo := LModelo + '                 AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), 0) AS VAL_DIFAL ';

  LModelo := LModelo + '    FROM MOVGER ';
  LModelo := LModelo + '    INNER JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  LModelo := LModelo + '    INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVGER.GER_CODEMP ';
  LModelo := LModelo + '    INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVGER.GER_NUMDOC ';
  LModelo := LModelo + '                     AND CADFIS.FIS_ESPDOC = MOVGER.GER_ESPDOC ';
  LModelo := LModelo + '                     AND CADFIS.FIS_CODEMP = MOVGER.GER_CODEMP ';
  LModelo := LModelo + '                     AND CADFIS.FIS_FORCLI = MOVGER.GER_CODCLI ';
  LModelo := LModelo + '    WHERE GER_TIP_FC = "C" ';
  LModelo := LModelo + '      AND LENGTH(FIS_ACESSO) > 0 ';
  LModelo := LModelo + '      AND GER_ORIDOC = "V" ';
  LModelo := LModelo + '      AND GER_ESPDOC = "NF" ';
  LModelo := LModelo + '      AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  LModelo := LModelo + '      AND LOCATE(GER_ESTADO, '+ QuotedStr(fRetornaUFsDeApuracao) +') > 0 ';
  LModelo := LModelo + '      CFG_CLAFIS ';
  LModelo := LModelo + '      AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  LModelo := LModelo + '      AND (SELECT COUNT(EMP_INSSUB) FROM EMPISB ';
  LModelo := LModelo + '            WHERE LENGTH(EMPISB.EMP_INSSUB) > 0 ';
  LModelo := LModelo + '              AND EMPISB.EMP_CODEMP = MOVGER.GER_CODEMP ';
  LModelo := LModelo + '              AND EMPISB.EMP_ESTADO = GER_ESTADO) > 0 ';
  LModelo := LModelo + '      AND (IF( AUX_TEM_ST = "S", AUX_TEM_ST = "S" AND ((AUX_GNEAUT = "N") AND (AUX_GNM_ST = "N")), FALSE ) OR ';
  LModelo := LModelo + '           IF( AUX_TEMFCP = "S", AUX_TEMFCP = "S" AND ((AUX_GNEFCP = "N") AND (AUX_GNMFCP = "N")), FALSE ) OR ';
  LModelo := LModelo + '           IF( AUX_TEMDFL = "S", AUX_TEMDFL = "S" AND ((AUX_GNEDFL = "N") AND (AUX_GNMDFL = "N")), FALSE )) ';

  LVenda     := AnsiReplaceStr(LModelo, 'CFG_CLAFIS', ' AND LOCATE(GER_CLAFIS, '+QuotedStr(VS_strClaVen)+' ) > 0 AND LEFT(GER_CLAFIS,1) >= 5 ');
  LDevolucao := AnsiReplaceStr(LModelo, 'CFG_CLAFIS', ' AND LOCATE(GER_CLAFIS, '+QuotedStr(VS_strClaDev)+' ) > 0 ');
  LDevolucao := AnsiReplaceStr(LDevolucao, 'SUM(DET_VALRET)', 'SUM(DET_VALRET) * -1');
  LDevolucao := AnsiReplaceStr(LDevolucao, 'SUM(ICD_VALFCP)', 'SUM(ICD_VALFCP) * -1');
  LDevolucao := AnsiReplaceStr(LDevolucao, 'SUM(DET_VFCPST)', 'SUM(DET_VFCPST) * -1');
  LDevolucao := AnsiReplaceStr(LDevolucao, 'SUM(ICD_VALDES)', 'SUM(ICD_VALDES) * -1');

  Result := LVenda;
  Result := Result + ' UNION ALL ' ;
  Result := Result + LDevolucao;

  Result := Result + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'MOVICD', 'NOTICD');

  Result := ' CREATE TEMPORARY TABLE TMP_APUGNR ' + Result;
end;

procedure TfrmGNREGuiasPorApuracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FreeAndNil(FObjLock);
end;

procedure TfrmGNREGuiasPorApuracao.FormCreate(Sender: TObject);
var
  intCorZeb: Integer;
  intCorFun: Integer;
  intCorFon: Integer;
begin
  inherited;
  FObjLock := TLock.Create;

  intCorZeb := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  intCorFun := strToIntDef(fCfgSis('CORFUN'), clMoneyGreen);
  intCorFon := strToIntDef(fCfgSis('CORFON'), clBlack);

  cxStyleZebrado.Color     := IIF(intCorZeb = -1, clMoneyGreen, intCorZeb);
  cxStyleSelecao.Color     := IIF(intCorFun = -1, clMoneyGreen, intCorFun);
  cxStyleSelecao.TextColor := IIF(intCorFon = -1, clBlack, intCorFon);

  FSemaforoConfirma := -1;
  fCarregaConfiguracoes;
end;

procedure TfrmGNREGuiasPorApuracao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
         VK_F3 : If btnGerarRegistros.Enabled Then btnGerarRegistros.Click;
         VK_F4 : If btnEditarRegistro.Enabled Then btnEditarRegistro.Click;
         VK_F5 : If btnExcluirRegistro.Enabled Then btnExcluirRegistro.Click;
         VK_F6 : If btnMarcarTodos.Enabled Then btnMarcarTodos.Click;
         VK_F7 : If btnDesmarcaTodos.Enabled Then btnDesmarcaTodos.Click;
         VK_F8 : If btnImprimirGuias.Enabled Then btnImprimirGuias.Click;
        VK_F10 : If btnGerarGuias.Enabled Then
                 Begin
                   Key := 0;
                   btnGerarGuias.Click;
                 End;
     VK_ESCAPE : If btnSair.Enabled Then btnSair.Click;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.FormResize(Sender: TObject);
begin
  inherited;
  Self.Left := (Screen.Width  - Self.Width)  div 2;
  Self.Top  := (Screen.Height - Self.Height) div 2;

  GroupST.Width    := Trunc(Self.Width / 3);
  GroupFCP.Width   := Trunc(Self.Width / 3);
  GroupDIFAL.Width := Trunc(Self.Width / 3);

  dbgConsultaDBView.OptionsView.ColumnAutoWidth := (Self.Width > 1536);
end;

procedure TfrmGNREGuiasPorApuracao.FormShow(Sender: TObject);
begin
  inherited;
  btnConfiguracoes.Visible := fVerificaAcessoSistema('CFGGNR');
  pLimpaFiltros;
  pHabilitaImpressao;
  icbMes.EditValue := IntToStr(MonthOf(VS_Date));
  cbxAno.Text := IntToStr(YearOf(VS_Date));
  WindowState := wsMaximized;
  pSetFocus(icbMes);
end;

procedure TfrmGNREGuiasPorApuracao.pApagaTabelaTemporaria;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'DROP TEMPORARY TABLE IF EXISTS TMP_APUGNR';
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pCriaTabelaTemporaria(ADtaIni, ADtaFin: TDateTime);
var
  qryAux: TUniQuery;
begin
  pApagaTabelaTemporaria;

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Text := fGetSqlTemporaria;
    qryAux.ParamByName('DTAINI').AsDate := ADtaIni;
    qryAux.ParamByName('DTAFIN').AsDate := ADtaFin;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pGravaArquivos(AOpcao: Integer; ACodEmp, AMesGnr, AAnoGnr: String; ADtaVen, ADtaPag: TDateTime; ADataSet: TUniQuery);
var
  qryAux: TUniQuery;
  LAutInc: String;
  LVlrPri: Double;
  LVlrFcp: Double;
begin

  LVlrPri := 0;
  LVlrFcp := 0;

  Case AOpcao of
    0: LVlrPri := ADataSet.FieldByName('VAL_ST').AsFloat;
    1: LVlrPri := ADataSet.FieldByName('VAL_FCP').AsFloat;
    2: LVlrPri := ADataSet.FieldByName('VAL_DIFAL').AsFloat;
  End;

  If ADataSet.FieldByName('GER_ESTADO').AsString = 'RJ' Then
  Begin
    Case AOpcao of
      0: LVlrFcp := ADataSet.FieldByName('VAL_FCP_ST').AsFloat;
      2: LVlrFcp := ADataSet.FieldByName('VAL_FCP').AsFloat;
    End;
  End;

  If not (LVlrPri > 0) Then
    Exit;

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT * FROM APUGNR WHERE FALSE';
    qryAux.Open;

    LAutInc := fRetAutoIncrem('APUGNR', VS_strCodEmp);

    qryAux.Insert;
    qryAux.FieldByName('AUTOINCREM').AsString   := LAutInc;
    qryAux.FieldByName('APU_CODEMP').AsString   := ACodEmp;
    qryAux.FieldByName('APU_ESTADO').AsString   := ADataSet.FieldByName('GER_ESTADO').AsString;
    qryAux.FieldByName('APU_I_E_S_').AsString   := ADataSet.FieldByName('EMP_INSSUB').AsString;
    qryAux.FieldByName('APU_TIPREC').AsString   := fTipoReceita(AOpcao);
    qryAux.FieldByName('APU_CODREC').AsString   := fReceita(AOpcao);
    qryAux.FieldByName('APU_MESGNR').AsString   := AMesGnr;
    qryAux.FieldByName('APU_ANOGNR').AsString   := AAnoGnr;
    qryAux.FieldByName('APU_DTACAD').AsDateTime := VS_Date;
    qryAux.FieldByName('APU_HORCAD').AsDateTime := fTime();
    qryAux.FieldByName('APU_DTAVEN').AsDateTime := ADtaVen;
    qryAux.FieldByName('APU_DTAPAG').AsDateTime := ADtaPag;
    qryAux.FieldByName('APU_VLRPRI').AsFloat    := LVlrPri;
    qryAux.FieldByName('APU_VLRFCP').AsFloat    := LVlrFcp;
    qryAux.FieldByName('APU_GNREOK').AsString   := 'N';
    qryAux.Post;

    pVinculaDocumentos(AOpcao, LAutInc, ADataSet.FieldByName('GER_ESTADO').AsString);

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pVinculaDocumentos(AOpcao: Integer; AAutInc, AEstado: String);
var
  qrySql: TUniQuery;
  qryUpd: TUniQuery;
  LTabela: String;
  LSeqGer: String;
begin
  qrySql := fCriaQuery;

  Try
    qrySql.Close;
    qrySql.SQL.Clear;
    qrySql.SQL.Add('SELECT AUTOINCREM, TABELA FROM TMP_APUGNR ');
    qrySql.SQL.Add('WHERE GER_ESTADO = :ESTADO ');

    Case AOpcao of
      0: qrySql.SQL.Add('  AND VAL_ST > 0 ');
      1: qrySql.SQL.Add('  AND VAL_FCP > 0 ');
      2: qrySql.SQL.Add('  AND VAL_DIFAL > 0 ');
    End;

    qrySql.ParamByName('ESTADO').AsString := AEstado;
    qrySql.Open;

    While not qrySql.Eof Do
    Begin
      LTabela := qrySql.FieldByName('TABELA').AsString;
      LSeqGer := qrySql.FieldByName('AUTOINCREM').AsString;

      qryUpd := fCriaQuery;

      Try
        qryUpd.Close;
        qryUpd.SQL.Clear;
        qryUpd.SQL.Add('UPDATE '+LTabela+' SET AUX_APUGNR = :APUGNR ');
        qryUpd.SQL.Add('WHERE AUX_SEQGER = :SEQGER ');
        qryUpd.ParamByName('APUGNR').AsString := AAutInc;
        qryUpd.ParamByName('SEQGER').AsString := LSeqGer;
        qryUpd.ExecSQL;
      Finally
        FreeAndNil(qryUpd);
      End;

      qrySql.Next;
    End;

  Finally
    FreeAndNil(qrySql);
  End;
end;

function TfrmGNREGuiasPorApuracao.fReceitaUtilizadaNaUF(AUF: String; AOpcao: Integer): Boolean;
var
  LUFs: String;
Begin
  case AOpcao of
    0: LUFs := UF_ST;
    1: LUFs := UF_FCP;
    2: LUFs := UF_DIFAL;
  end;

  Result := (Pos(AUF, LUFs) > 0);
End;

function TfrmGNREGuiasPorApuracao.fExisteApuracao(AOpcao: Integer; AEstado, ACodEmp, AMesGnr, AAnoGnr: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Add('SELECT * FROM APUGNR ');
    qryAux.SQL.Add('WHERE APU_TIPREC = :TIPREC ');
    qryAux.SQL.Add('  AND APU_ESTADO = :ESTADO ');
    qryAux.SQL.Add('  AND APU_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND APU_MESGNR = :MESGNR ');
    qryAux.SQL.Add('  AND APU_ANOGNR = :ANOGNR ');
    qryAux.ParamByName('TIPREC').AsString := fTipoReceita(AOpcao);
    qryAux.ParamByName('ESTADO').AsString := AEstado;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ParamByName('MESGNR').AsString := AMesGnr;
    qryAux.ParamByName('ANOGNR').AsString := AAnoGnr;
    qryAux.Open;

    Result := (qryAux.RecordCount > 0);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pPreparaApuracao;
var
  LContinua: Boolean;

  function fRetMes(AMes: String): Integer;
  begin
    Result := 1;

    If AMes = 'JANEIRO'   Then Result := 1;
    If AMes = 'FEVEREIRO' Then Result := 2;
    If AMes = 'MARÇO'     Then Result := 3;
    If AMes = 'ABRIL'     Then Result := 4;
    If AMes = 'MAIO'      Then Result := 5;
    If AMes = 'JUNHO'     Then Result := 6;
    If AMes = 'JULHO'     Then Result := 7;
    If AMes = 'AGOSTO'    Then Result := 8;
    If AMes = 'SETEMBRO'  Then Result := 9;
    If AMes = 'OUTUBRO'   Then Result := 10;
    If AMes = 'NOVEMBRO'  Then Result := 11;
    If AMes = 'DEZEMBRO'  Then Result := 12;
  End;

begin
  pCriarFormularios(TfrmGNREGuiasPorApuracaoDatas, frmGNREGuiasPorApuracaoDatas);

  Try
    frmGNREGuiasPorApuracaoDatas.ShowModal;

    LContinua := (frmGNREGuiasPorApuracaoDatas.ModalResult = mrOk);

    FMesGnr := frmGNREGuiasPorApuracaoDatas.FMesGnr;
    FAnoGnr := frmGNREGuiasPorApuracaoDatas.FAnoGnr;
    FDtaIni := frmGNREGuiasPorApuracaoDatas.FDtaIni;
    FDtaFin := frmGNREGuiasPorApuracaoDatas.FDtaFin;
    FDtaVen := frmGNREGuiasPorApuracaoDatas.FDtaVen;
    FDtaPag := frmGNREGuiasPorApuracaoDatas.FDtaPag;

  Finally
    pFreeAndNil(frmGNREGuiasPorApuracaoDatas);
  End;

  If not LContinua Then
    Exit;

  If not fDataValida(FDtaIni) Then
    Exit;

  If not fDataValida(FDtaFin) Then
    Exit;

  If not fDataValida(FDtaVen) Then
    Exit;

  If not fDataValida(FDtaPag) Then
    Exit;

  TfrmGravando.fExecutarModalA(pGeraApuracao, 'Gerando registro de apuração . . .', '');

  pMensagemOk('Processamento finalizado!');
  rdgSituacao.ItemIndex := 1;
  icbMes.ItemIndex := fRetMes(FMesGnr) -1;
  cbxAno.Text := FAnoGnr;
  btnConsultar.Click;

end;

procedure TfrmGNREGuiasPorApuracao.pGeraApuracao;
var
  qryAux: TUniQuery;
  LOpcao: Integer;
  LContador: Integer;
  LEstado: String;

begin

  pCriaTabelaTemporaria(FDtaIni, FDtaFin);

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Text := fGetSqlApuracao;
    qryAux.Open;

    pgbProgresso.Max := qryAux.RecordCount;
    pgbProgresso.Position := 0;

    qryAux.DisableControls;
    qryAux.First;

    While Not qryAux.Eof Do
    Begin

      LEstado := qryAux.FieldByName('GER_ESTADO').AsString;

      For LContador := 0 To 2 Do
      Begin

        LOpcao := LContador;

        If LEstado = 'RJ' Then
        Begin
          Case LContador Of
            1: LOpcao := 2;
            2: Break;
          End;
        End;

        If fReceitaUtilizadaNaUF(LEstado, LOpcao) Then
        Begin
          If not fExisteApuracao(LOpcao, LEstado, VS_strCodEmp, FMesGnr, FAnoGnr) Then
            pGravaArquivos(LOpcao, VS_strCodEmp, FMesGnr, FAnoGnr, FDtaVen, FDtaPag, qryAux);
        End;

      End;

      pgbProgresso.Position := qryAux.Recno;

      If (pgbProgresso.Position Mod 5 = 0) Then
        Application.ProcessMessages;

      qryAux.Next;
    End;

  Finally
    qryAux.EnableControls;
    FreeAndNil(qryAux);
    pgbProgresso.Position := 0;
    pApagaTabelaTemporaria;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pGnreConfigurar(var WSGnre: TWSGnre);
begin
  case FOpcao of
    0: WSGnre.TipoReceita := ST;
    1: WSGnre.TipoReceita := FCP;
    2: WSGnre.TipoReceita := DIFAL;
  end;

  WSGnre.Configuracoes.GnreSt                := fCfgSis('GNRAST');
  WSGnre.Configuracoes.GnreDf                := fCfgSis('GNRADF');
  WSGnre.Configuracoes.GnreFc                := fCfgSis('GNRAFC');
  WSGnre.Configuracoes.GnrePagarSt           := fCfgSis('CTAPST');
  WSGnre.Configuracoes.GnrePagarDf           := fCfgSis('CTAPDF');
  WSGnre.Configuracoes.GnrePagarFc           := fCfgSis('CTAPFC');
  WSGnre.Configuracoes.GnreForSt             := fCfgSis('FORGST');
  WSGnre.Configuracoes.GnreForDf             := fCfgSis('FORGDF');
  WSGnre.Configuracoes.GnreForFc             := fCfgSis('FORGFC');
  WSGnre.Configuracoes.GnrePorSt             := fCfgSis('GPORST');
  WSGnre.Configuracoes.GnrePorDf             := fCfgSis('GPORDF');
  WSGnre.Configuracoes.GnrePorFc             := fCfgSis('GPORFC');
  WSGnre.Configuracoes.UsarCapicom           := fCfgSis('CAPCOM', varBoolean);
  WSGnre.Configuracoes.UsarCapicomArquivoPFX := fCfgSis('USAPFX', varBoolean);
  WSGnre.Configuracoes.CertificadoArquivoPFX := FCertificadoPFX;
  WSGnre.Configuracoes.CertificadoArquivoPEM := FCertificadoPEM;
  WSGnre.Configuracoes.CertificadoArquivoKEY := FCertificadoKEY;
  WSGnre.Configuracoes.CertificadoSenha      := FCertificadoSenha;
  WSGnre.Configuracoes.SerialCertificado     := FSerialCertificado;
  WSGnre.Configuracoes.GnreApuracao          := True;
  WSGnre.Configuracoes.Homologacao           := False;
  WSGnre.Configuracoes.ToleranciaBoleto      := fCfgSis('TOLGNR', varDouble);
end;

procedure TfrmGNREGuiasPorApuracao.pGnrePreencherGuia(var WSGnre: TWSGnre);
begin
  WSGnre.DadosGuia.UfFavorecida                          := cdsConsulta.FieldByName('APU_ESTADO').AsString;
  WSGnre.DadosGuia.DataEmissao                           := cdsConsulta.FieldByName('APU_DTACAD').AsString;
  WSGnre.DadosGuia.DataVencimento                        := cdsConsulta.FieldByName('APU_DTAVEN').AsString;
  WSGnre.DadosGuia.DataPagamento                         := cdsConsulta.FieldByName('APU_DTAPAG').AsString;
  WSGnre.DadosGuia.ChaveDeApuracao                       := cdsConsulta.FieldByName('AUTOINCREM').AsString;
  WSGnre.DadosGuia.CodigoDaReceita                       := fReceita(FOpcao);
  WSGnre.DadosGuia.ContribuinteEmitenteIE                := fTiraCaracEspeciais(cdsConsulta.FieldByName('APU_I_E_S_').AsString,True,True,True);
  WSGnre.DadosGuia.ContribuinteEmitenteCNPJ              := fTiraCaracEspeciais(fCadEmp('C_G_C_'), True, True);
  WSGnre.DadosGuia.ContribuinteEmitenteRazaoSocial       := Trim(fTiraCaracEspeciais( Trim(fCadEmp('NOMEMP'))));
  WSGnre.DadosGuia.ContribuinteEmitenteEndereco          := Trim(fCadEmp('ENDERE'));
  WSGnre.DadosGuia.ContribuinteEmitenteMunicipio         := Copy(fRetornaCodIBGE(fCadEmp('CODCID')),3,5);
  WSGnre.DadosGuia.ContribuinteEmitenteUf                := Trim(fCadEmp('ESTADO'));
  WSGnre.DadosGuia.ContribuinteEmitenteCep               := fPadR(fTiraCaracEspeciais(fCadEmp('C_E_P_'), True, True),8,'0');
  WSGnre.DadosGuia.ContribuinteEmitenteTelefone          := fTiraCaracEspeciais(fCadEmp('FONE01'), True, True);
  WSGnre.DadosGuia.ContribuinteDestinatarioTipoPessoa    := '1';
  WSGnre.DadosGuia.ContribuinteDestinatarioInscrEstadual := fTiraCaracEspeciais(cdsConsulta.FieldByName('APU_I_E_S_').AsString,True,True,True);

  If WSGnre.DadosGuia.UfFavorecida = 'RJ' Then
  Begin
    WSGnre.DadosGuia.ValorICMS                           := AnsiReplaceStr(FormatFloat('#0.00', cdsConsulta.FieldByName('APU_VLRPRI').AsFloat),',','.');
    WSGnre.DadosGuia.ValorFECP                           := AnsiReplaceStr(FormatFloat('#0.00', cdsConsulta.FieldByName('APU_VLRFCP').AsFloat),',','.');
    WSGnre.DadosGuia.ValorGNRE                           := AnsiReplaceStr(FormatFloat('#0.00', cdsConsulta.FieldByName('APU_VLRPRI').AsFloat + cdsConsulta.FieldByName('APU_VLRFCP').AsFloat),',','.');
  End
  Else
    WSGnre.DadosGuia.ValorGNRE                           := AnsiReplaceStr(FormatFloat('#0.00', cdsConsulta.FieldByName('APU_VLRPRI').AsFloat),',','.');

  WSGnre.TipoWebService := GnrePernambuco;

  If Pos(WSGnre.DadosGuia.UfFavorecida, fTransform(fCfgSis('GNR200'), 2)) > 0 Then
    WSGnre.VersaoGnrePE := Versao2
  Else
    WSGnre.VersaoGnrePE := Versao1;

end;

procedure TfrmGNREGuiasPorApuracao.pGnreRegistraSituacaoDaGuia(AMensagem: String);
var
  LSQL  : String;
  LCampo: String;
begin

  Case FOpcao of
    0: LCampo := 'APU_ST_REJ';
    1: LCampo := 'APU_FCPREJ';
    2: LCampo := 'APU_DFLREJ';
  End;

  LSQL :=        'UPDATE APUGNR SET '+ LCampo +' = '+ QuotedStr( AMensagem );
  LSQL := LSQL + ' WHERE AUTOINCREM = '+ QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  fExecutaSQL(LSQL);
end;

procedure TfrmGNREGuiasPorApuracao.pGnreRejeicao(ATeveRejeicao: Boolean);
var
  LSQL  : String;
begin
  LSQL :=        'UPDATE APUGNR SET APU_GNRREJ = '+ IIF(ATeveRejeicao, QuotedStr('S'), QuotedStr('N'));
  LSQL := LSQL + ' WHERE AUTOINCREM = '+ QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  fExecutaSQL(LSQL);
end;

function TfrmGNREGuiasPorApuracao.fExisteFinanceiro(AChaveDeApuracao, ACodigoDaReceita: String): Boolean;
var
  LQryAux: TUniQuery;
begin
  LQryAux := fCriaQuery;

  Try
    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM CADPAG');
    LQryAux.SQL.Add('WHERE IFNULL(CTP_GNRCTR,"") <> "" ');
    LQryAux.SQL.Add('  AND CTP_APUGNR = :APUGNR ');
    LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');

    LQryAux.ParamByName('APUGNR').AsString := AChaveDeApuracao;
    LQryAux.ParamByName('CODREC').AsString := ACodigoDaReceita;
    LQryAux.Open;

    Result := (LQryAux.FieldByName('QTDE').AsInteger > 0);
  Finally
    FreeAndNil(LQryAux);
  End;
end;

function TfrmGNREGuiasPorApuracao.fExisteFinanceiroBaixado(AChaveDeApuracao, ACodigoDaReceita: String): Boolean;
var
  LQryAux: TUniQuery;
begin
  LQryAux := fCriaQuery;

  Try
    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM CADPAG');
    LQryAux.SQL.Add('WHERE IFNULL(CTP_GNRCTR,"") <> "" ');
    LQryAux.SQL.Add('  AND CTP_VALPAG > 0 ');
    LQryAux.SQL.Add('  AND CTP_APUGNR = :APUGNR ');
    LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');

    LQryAux.ParamByName('APUGNR').AsString := AChaveDeApuracao;
    LQryAux.ParamByName('CODREC').AsString := ACodigoDaReceita;
    LQryAux.Open;

    Result := (LQryAux.FieldByName('QTDE').AsInteger > 0);
  Finally
    FreeAndNil(LQryAux);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pGravaLogCadPag(ANumDup, AParcel: String; ASeqBai: Integer; ACodEmp, ACodFor, ASerie_: String);
var
  objPag: TCadPag;
  objRep: TCadPagRepository;
begin
  objRep := TCadPagRepository.Create;

  Try
    objPag := objRep.fRetDuplicata(ANumDup, AParcel, ASeqBai, ACodEmp, ACodFor, ASerie_);

    If Assigned(objPag) Then
    begin
      untLogCtp.pGravaLogCtp(objPag, 'GNRE PE APURAÇÃO - ALTERAÇÃO DO CÓDIGO DE BARRAS, LINHA DIGITÁVEL E VENCIMENTO', Self.Name);
    end;

  Finally
    FreeAndNil(objRep);
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pGnreApagaFinanceiro(AChaveDeApuracao:String);
var
  LSQL     : String;
  LQryAux  : TUniQuery;
  LContador: Integer;
  LCodigoDaReceita: String;
begin

  If fEmptyStr(AChaveDeApuracao) Then
    Exit;

  For LContador := 0 To 2 Do
  Begin
    LCodigoDaReceita := fReceita(LContador);

    If not fExisteFinanceiroBaixado(AChaveDeApuracao, LCodigoDaReceita) Then
    begin
      LSQL :=        'UPDATE APUGNR SET APU_GNREOK = "N" ';
      LSQL := LSQL + 'WHERE AUTOINCREM = '+ QuotedStr(AChaveDeApuracao);
      fExecutaSQL(LSQL);

      Try
        LQryAux := fCriaQuery;

        LQryAux.Close;
        LQryAux.SQL.Clear;
        LQryAux.SQL.Add('SELECT * FROM CADPAG ');
        LQryAux.SQL.Add('WHERE CTP_VALPAG = 0 ');
        LQryAux.SQL.Add('  AND CTP_APUGNR = :APUGNR ');
        LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');
        LQryAux.ParamByName('APUGNR').AsString := AChaveDeApuracao;
        LQryAux.ParamByName('CODREC').AsString := LCodigoDaReceita;
        LQryAux.Open;

        While Not LQryAux.Eof Do
        Begin
          fApagaDuplicataContasPagar(LQryAux, Self.Name);
          LQryAux.Next;
        End;

      Finally
        FreeAndNil(LQryAux);
      End;
    end;
  End;
end;

function TfrmGNREGuiasPorApuracao.fGnreGerarFinanceiro(ACodigoDaReceita, AChaveDeApuracao, AConvenio, ANumeroDeControle, ACodBarra, ALinhaDigitavel, AQrCode: String; AVlrMulta, AVlrJuros, AVlrDuplicata: Double ): Boolean;
var
 LQryUpdate  : TUniQuery;
 LSqlAux     : String;
 LHistorico  : String;
 LPlanoContas: String;
 LFornecedor : String;
 LPortador   : String;
 LNumDoc     : String;
 LEstado     : String;
 LVlrOriginal: Double;
 LVlrJuros   : Double;
 LVlrMulta   : Double;
Begin
  Result := True;

  Try

    Case FOpcao of
      0:Begin
          LFornecedor  := FGnreForSt;
          LPlanoContas := FGnrePagarSt;
          LPortador    := FGnrePorSt;
        End;
      1:Begin
          LFornecedor  := FGnreForFc;
          LPlanoContas := FGnrePagarFc;
          LPortador    := FGnrePorFc;
        End;
      2:Begin
          LFornecedor  := FGnreForDf;
          LPlanoContas := FGnrePagarDf;
          LPortador    := FGnrePorDf;
        End;
    End;

    LEstado := cdsConsulta.FieldByName('APU_ESTADO').AsString;
    LVlrOriginal := cdsConsulta.FieldByName('APU_VLRPRI').AsFloat;

    If LEstado = 'RJ' Then
    Begin
      LVlrOriginal := (cdsConsulta.FieldByName('APU_VLRPRI').AsFloat + cdsConsulta.FieldByName('APU_VLRFCP').AsFloat);
    End;

    LVlrJuros := AVlrDuplicata - LVlrOriginal;
    LVlrMulta := 0;

    If (LVlrJuros > 0) And (AVlrMulta > 0) And (AVlrJuros > 0) And (CompareValue(LVlrJuros, (AVlrMulta + AVlrJuros), 0.01) = EqualsValue) Then
    Begin
      LVlrJuros := AVlrJuros;
      LVlrMulta := AVlrMulta;
    End;

    If not fExisteFinanceiro(AChaveDeApuracao, ACodigoDaReceita) Then
    Begin
      LNumDoc := fRetSequencialCadPag;

      LHistorico := 'GNRE NACIONAL POR APURAÇÃO GERADA AUTOMATICAMENTE, ';

      Case FOpcao of
        0: LHistorico := LHistorico +'UF: '+LEstado+' - SUBSTITUIÇÃO TRIBUTÁRIA ';
        1: LHistorico := LHistorico +'UF: '+LEstado+' - FUNDO DE COMBATE A POBREZA ';
        2: LHistorico := LHistorico +'UF: '+LEstado+' - DIFAL ';
      End;

      LHistorico := LHistorico + 'REFERENTE ' + cdsConsulta.FieldByName('APU_MESGNR').AsString +'/'+
                                                cdsConsulta.FieldByName('APU_ANOGNR').AsString ;

      Result := fGravaCadPag(Self.Name,                                       // Nome Form LOGCTP
                     'GNRE NACIONAL POR APURAÇÃO - EXPORTAÇÃO DE SAÍDA',      // Descrição LOGCTP
                     LFornecedor,                                             // Fornecedor
                     fStrZero(LNumDoc, 12),                                   // Numero da Duplicata
                     'A',                                                     // Parcela
                     VS_strCodEmp,                                            // Empresa
                     LPlanoContas,                                            // Centro de Custo
                     '001',                                                   // Serie do Documento
                     0,                                                       // Sequencial de Baixa
                     VS_Date,                                                 // Data do lançamento
                     cdsConsulta.FieldByName('APU_DTAVEN').AsDateTime,        // Data de Vencimento
                     LVlrOriginal,                                            // Valor da Duplicata
                     LVlrOriginal,                                            // Valor Original
                     'N',                                                     // Previsão?
                     'N',                                                     // Veio Boleto
                     'N',                                                     // Deposito
                     LHistorico,                                              // Histórico 1
                     '',                                                      // Histórico 2
                     '',                                                      // Histórico da Baixa
                     '',                                                      // Portador da Baixa
                     '',                                                      // Centro de Custo da Baixa
                     '',                                                      // Documento da Baixa
                     '',                                                      // Operador da Baixa
                     0,                                                       // Data do Pagamento
                     0,                                                       // Valor Pago
                     0,                                                       // Valor de Juros após pagamento
                     0,                                                       // Valor Desconto
                     VS_strCodEmp,                                            // Empresa
                     FGnreEvento,                                             // Código do Evento
                     'N',                                                     // Usa Cheque
                     LPortador,                                               // Codigo do Portador
                     '',                                                      // Numero do Documento
                     LVlrJuros,                                               // Valor de Juros antes do pagamento
                     0.0,
                     0,
                     False,
                     0,
                     '2',
                     0,
                     'S',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     'N',
                     FormatDateTime('mm/yyyy', VS_Date),
                     '',
                     '',
                     '',
                     '',
                     0,
                     0,
                     0,
                     0,
                     '',
                     0,
                     0,
                     ALinhaDigitavel,
                     ACodBarra,
                     '',
                     '',
                     '',
                     '7',
                     ACodigoDaReceita,
                     '',
                     '',
                     '',
                     'N',
                     '',
                     '',
                     '',
                     ANumeroDeControle,
                     cdsConsulta.FieldByName('APU_DTAPAG').AsDateTime,
                     AConvenio,
                     LVlrMulta,
                     '',
                     0,
                     0,
                     0,
                     '',
                     cdsConsulta.FieldByName('AUTOINCREM').AsString,
                     '',
                     AQrCode);

    End
    Else
    Begin
      LQryUpdate := fCriaQuery;

      Try
        LQryUpdate.Close;
        LQryUpdate.SQL.Clear;
        LQryUpdate.SQL.Add('UPDATE CADPAG SET CTP_DTAVEN = :DTAVEN, ');
        LQryUpdate.SQL.Add('                  CTP_VALDUP = :VALDUP, ');
        LQryUpdate.SQL.Add('                  CTP_JURSUJ = :JURSUJ, ');
        LQryUpdate.SQL.Add('                  CTP_MULSUJ = :MULSUJ, ');
        LQryUpdate.SQL.Add('                  CTP_GNRDPG = :GNRDPG, ');
        LQryUpdate.SQL.Add('                  CTP_GNRCTR = :GNRCTR, ');
        LQryUpdate.SQL.Add('                  CTP_QRCODE = :QRCODE, ');
        LQryUpdate.SQL.Add('                  CTP_CODBAR = :CODBAR, ');
        LQryUpdate.SQL.Add('                  CTP_LINDIG = :LINDIG  ');
        LQryUpdate.SQL.Add('WHERE CTP_VALPAG = 0 ');
        LQryUpdate.SQL.Add('  AND CTP_APUGNR = :APUGNR ');
        LQryUpdate.SQL.Add('  AND CTP_CODREC = :CODREC ');

        LQryUpdate.ParamByName('APUGNR').AsString := AChaveDeApuracao;
        LQryUpdate.ParamByName('CODREC').AsString := ACodigoDaReceita;
        LQryUpdate.ParamByName('DTAVEN').AsDate   := cdsConsulta.FieldByName('APU_DTAVEN').AsDateTime;
        LQryUpdate.ParamByName('GNRDPG').AsDate   := cdsConsulta.FieldByName('APU_DTAPAG').AsDateTime;
        LQryUpdate.ParamByName('QRCODE').AsString := AQrCode;
        LQryUpdate.ParamByName('GNRCTR').AsString := ANumeroDeControle;
        LQryUpdate.ParamByName('CODBAR').AsString := ACodBarra;
        LQryUpdate.ParamByName('LINDIG').AsString := ALinhaDigitavel;
        LQryUpdate.ParamByName('VALDUP').AsFloat  := LVlrOriginal;
        LQryUpdate.ParamByName('JURSUJ').AsFloat  := LVlrJuros;
        LQryUpdate.ParamByName('MULSUJ').AsFloat  := LVlrMulta;

        LQryUpdate.ExecSQL;

        LQryUpdate.Close;
        LQryUpdate.SQL.Clear;
        LQryUpdate.SQL.Add('SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, CTP_CODEMP, CTP_CODFOR, CTP_SERIE_, CTP_VALPAG FROM CADPAG');
        LQryUpdate.SQL.Add('WHERE CTP_APUGNR = :APUGNR ');
        LQryUpdate.SQL.Add('  AND CTP_CODREC = :CODREC ');

        LQryUpdate.ParamByName('APUGNR').AsString := AChaveDeApuracao;
        LQryUpdate.ParamByName('CODREC').AsString := ACodigoDaReceita;
        LQryUpdate.Open;

        If LQryUpdate.FieldByName('CTP_VALPAG').AsFloat = 0 Then
        Begin
          pGravaLogCadPag(LQryUpdate.FieldByName('CTP_NUMDUP').AsString,
                          LQryUpdate.FieldByName('CTP_PARCEL').AsString,
                          LQryUpdate.FieldByName('CTP_SEQBAI').AsInteger,
                          LQryUpdate.FieldByName('CTP_CODEMP').AsString,
                          LQryUpdate.FieldByName('CTP_CODFOR').AsString,
                          LQryUpdate.FieldByName('CTP_SERIE_').AsString);
        End;

      Finally
        FreeAndNil(LQryUpdate);
      End;
    End;

    If Result Then
    Begin
      LSqlAux :=        'UPDATE APUGNR SET APU_GNREOK = "S" ';
      LSqlAux := LSqlAux + ' WHERE AUTOINCREM = '+ QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      fExecutaSQL(LSqlAux);

      fExecutaSQL(LSqlAux);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;

      pMensagensErro(E.Message,'[TfrmGNREGuiasPorApuracao.fGnreGerarFinanceiro]');
    End;
  End;

end;

function TfrmGNREGuiasPorApuracao.fGnreEnviar(var WSGnre: TWSGnre): Boolean;
begin
  fStartTransaction;

  Result := WSGnre.fGerarGuia;

  pGnreRegistraSituacaoDaGuia(WSGnre.retorno.Mensagem);

  If not Result Then
  begin
    pGnreApagaFinanceiro(WSGnre.Retorno.ChaveDeApuracao);
  end;

  If fInTransaction Then
    fCommit;

  Try
    If Result Then
    Begin
      fStartTransaction;

      Result := fGnreGerarFinanceiro(WSGnre.Retorno.CodigoDaReceita,
                                     WSGnre.Retorno.ChaveDeApuracao,
                                     WSGnre.Retorno.CodigoConvenio,
                                     WSGnre.Retorno.Boleto.NumeroDeControle,
                                     WSGnre.Retorno.Boleto.CodigoDeBarras,
                                     WSGnre.Retorno.Boleto.LinhaDigitavel,
                                     WSGnre.Retorno.Boleto.QrCode,
                                     WSGnre.Retorno.Boleto.Multa,
                                     WSGnre.Retorno.Boleto.Juros,
                                     WSGnre.Retorno.Boleto.Valor);

    End;

  Finally
    If fInTransaction Then
    Begin
      If Result Then
        fCommit
      Else
        fRollBack;
    End;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pCarregaDocumentosParaImpressao;
var
  LRecno   : Integer;
  LContador: Integer;
begin
  LRecno := cdsConsulta.RecNo;

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        For LContador := 0 To 2 Do
        Begin
          GNREModulo.pPreparaBoletoApuracao(False, True, fReceita(LContador), cdsConsulta.FieldByName('AUTOINCREM').AsString, fRetornaTipoReceitaGNRE(LContador));
        End;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := LRecno;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.pImprimirGuias;
var
  LDocSel  : Integer;
Begin

  LDocSel := fDocumentosSelecionados;

  If LDocSel > 0 Then
  Begin
    If (fMensagem('', 'Foi selecionado ' + IntToStr(LDocSel) + ' documento(s).' + #13 +
                      'Deseja confirmar a impressão ?', ['&Sim', '&Não']) = 1) Then
    Begin
      pCriarFormularios(TGNREModulo, GNREModulo);
      Try
        TfrmGravando.fExecutarModalA(pCarregaDocumentosParaImpressao, 'Carregando documentos para impressão . . .', '');

        GNREModulo.pImprimir(Self.Name,fCfgSis('GNRIMP'));

      Finally
        pFreeAndNil(GNREModulo);
      End;
    End;
  End
  Else
    pMensagemOk('Nenhum documento foi selecionado!');

End;

procedure TfrmGNREGuiasPorApuracao.pGnreImprimirGuias;
begin

  Try
    pCriarFormularios(TGNREModulo, GNREModulo);

    TfrmGravando.fExecutarModalA(pCarregaDocumentosParaImpressao, 'Carregando documentos para impressão . . .', '');

    GNREModulo.pImprimir(Self.Name, FImpressora);

  Finally
    pFreeAndNil(GNREModulo);
  End;

end;

procedure TfrmGNREGuiasPorApuracao.pGerarGuias;
var
  WSGnre    : TWSGnre;
  LResultado: Boolean;
begin
  pgbProgresso.Max := cdsConsulta.RecordCount;
  pgbProgresso.Position := 0;

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    begin

      If (cdsConsulta.FieldByName('SELECIONADO').AsString = 'S') Then
      begin

        Try
          WSGnre := TWSGnre.Create(Self);

          Case cdsConsulta.FieldByName('APU_TIPREC').AsString[1] Of
            'S': FOpcao := 0;
            'F': FOpcao := 1;
            'D': FOpcao := 2;
          End;

          pGnreConfigurar(WSGnre);
          pGnrePreencherGuia(WSGnre);

          LResultado := fGnreEnviar(WSGnre);

          pGnreRejeicao(not LResultado);

        Finally
          FreeAndNil(WSGnre);
        End;
      end;

      pgbProgresso.Position := cdsConsulta.Recno;

      If (pgbProgresso.Position Mod 5 = 0) Then
        Application.ProcessMessages;

      cdsConsulta.Next;
    end;

    pgbProgresso.Position := 0;

    cdsConsulta.EnableControls;

    pGnreImprimirGuias;

    btnConsultar.Click;

  Except
    On E: Exception Do
    Begin
      If fInTransaction Then
        fRollBack;

      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[TfrmGNREGuiasPorApuracao.pGerarGuias]');
    End;
  End;
end;

function TfrmGNREGuiasPorApuracao.fExisteFinanceiroBaixado(AChaveDeApuracao: String): Boolean;
var
  LQryAux: TUniQuery;
begin

  Try
    LQryAux := fCriaQuery;

    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT AUTOINCREM, CTP_VALPAG FROM CADPAG');
    LQryAux.SQL.Add('WHERE CTP_VALPAG > 0 ');
    LQryAux.SQL.Add('  AND CTP_APUGNR = :APUGNR ');

    LQryAux.ParamByName('APUGNR').AsString := AChaveDeApuracao;
    LQryAux.Open;

    Result := not LQryAux.IsEmpty;
  Finally
    FreeAndNil(LQryAux);
  End;

end;

function TfrmGNREGuiasPorApuracao.fValidaExisteFinanceiroBaixado:Boolean;
var
  LRecno: Integer;
Begin
  Result := False;

  LRecno := cdsConsulta.recno;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        Result := fExisteFinanceiroBaixado(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      End;

      If Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido selecionar documento com contas a pagar baixado'+#13+
                              '  UF:  '+cdsConsulta.FieldByName('APU_ESTADO').AsString+
                              '  Tp.Receita:  '+cdsConsulta.FieldByName('APU_TIPREC').AsString+
                              '  Competência:  '+cdsConsulta.FieldByName('APU_MESGNR').AsString+'/'+cdsConsulta.FieldByName('APU_ANOGNR').AsString, ['&Ok']);
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Recno := LRecno;
    cdsConsulta.EnableControls;
  End;

end;

function TfrmGNREGuiasPorApuracao.fValidaCapicom: Boolean;
begin
  Result := False;

  If not fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If not fEmptyStr(FSerialCertificado) Then
    Exit;

  Result := True;
end;

function TfrmGNREGuiasPorApuracao.fValidaCertificadoSerial:Boolean;
begin
  Result := True;

  If not fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  Result := Assigned(fGetCertificadoSerial(FSerialCertificado));
end;

function TfrmGNREGuiasPorApuracao.fValidaOpenSSLCertificadoPFX: Boolean;
begin
  Result := False;

  If fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If not fEmptyStr(FCertificadoPFX) Then
    Exit;

  Result := True;
end;

function TfrmGNREGuiasPorApuracao.fGuiaComDatasOK: Boolean;
var
  LRecno: Integer;
Begin
  Result := True;

  LRecno := cdsConsulta.recno;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        If cdsConsulta.FieldByName('APU_DTAPAG').AsDateTime < VS_Date Then
        Begin
          Result := False;
          Break;
        End;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Recno := LRecno;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmGNREGuiasPorApuracao.btnGerarGuiasClick(Sender: TObject);
var
  LDocSel: Integer;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (fDocumentosSelecionados = 0) Then
  Begin
    pMensagemOk('Nenhum documento foi selecionado!');
    Exit;
  End;

  If fValidaCapicom Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione o Certificado Digital!', ['&Ok']);
    Exit;
  End;

  If not fValidaCertificadoSerial Then
  Begin
    fMensagem('ATENÇÃO!', 'Certificado Digital Inválido.'+#13+
                          'Selecione o Certificado Digital!', ['&Ok']);
    Exit;
  End;

  If fValidaOpenSSLCertificadoPFX Then
  Begin
    fMensagem('ATENÇÃO!', 'Necessário cadastrar o Certificado Digital.'+#13+
                          'Acesse: Cadastro de Empresas [Certificado Digital].', ['&Ok']);
    Exit;
  End;

  If not fGuiaComDatasOK Then
  Begin
    fMensagem('ATENÇÃO!', 'Existe registros com datas de vencimento ou pagamento inválida!', ['&Ok']);
    Exit;
  End;

  If fValidaExisteFinanceiroBaixado Then
    Exit;

  If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
  Begin
    Try
      LDocSel := fDocumentosSelecionados;

      If LDocSel > 0 Then
      Begin
        If (fMensagem('', 'Foi selecionado ' + IntToStr(LDocSel) + ' documento(s).' + #13 +
                          'Deseja confirmar a operação ?', ['&Sim', '&Não']) = 1) Then
        Begin
          TfrmGravando.fExecutarModalA(pGerarGuias, 'Gerando guias GNRE por apuração . . .', '');
        End;
      End
      Else
        pMensagemOk('Nenhum documento foi selecionado!');
    Finally
      InterlockedDecrement(FSemaforoConfirma);
    End;
  End
  Else
    InterlockedDecrement(FSemaforoConfirma);

end;

end.
