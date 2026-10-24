{***************************}
{* qryCadCar -> CADCAR     *}
{************************RV*}
unit untEstornaCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, QColorLabel,
  BitBtnLockedIncrem, cxProgressBar, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, untFechamentoFinanceiro,
  cxTextEdit, cxGroupBox, Datasnap.DBClient, Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, StrUtils,
  untConsultas,  untTypesSistema, untFuncoesConsulta, untMovcar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmEstornaCartoes = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    edtTipoData: TEditFocus;
    ColorLabel1: TColorLabel;
    Label11: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    gpbGeral: TGroupBox;
    gpbSelecionados: TGroupBox;
    edtQtdSel: TEditFocus;
    edtValSel: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtQtdGer: TEditFocus;
    Label7: TLabel;
    Label9: TLabel;
    edtValGer: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarrTitulos: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    cxgConsulta: TcxGridCitel;
    cxgConsultaTableView: TcxGridDBTableViewCitel;
    cxgConsultaTableViewMCA_NUMCCD: TcxGridDBColumn;
    cxgConsultaTableViewMCA_NUMNSU: TcxGridDBColumn;
    cxgConsultaTableViewMCA_CODEMP: TcxGridDBColumn;
    cxgConsultaTableViewMCA_DTAVEN: TcxGridDBColumn;
    cxgConsultaTableViewMCA_DTACAD: TcxGridDBColumn;
    cxgConsultaTableViewMCA_DTABAI: TcxGridDBColumn;
    cxgConsultaTableViewMCA_DTAREC: TcxGridDBColumn;
    cxgConsultaTableViewMCA_VALTOT: TcxGridDBColumn;
    cxgConsultaTableViewMCA_VALSTA: TcxGridDBColumn;
    cxgConsultaTableViewMCA_DOCUME: TcxGridDBColumn;
    cxgConsultaTableViewAUTOINCREM: TcxGridDBColumn;
    cxgConsultaLevel: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dtsConsultaDataChange(Sender: TObject; Field: TField);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure cxgConsultaTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgConsultaTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgConsultaTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryCadCar, qryCadEmp, qryCadPag: TUniQuery;
    blnDtaDoc: Boolean;

    arrCartao: TConsultasArray;
    arrEmp   : TConsultasArray;

    qryEstCar: TUniQuery;
    blnBaixad: Boolean;
    blnMarTod: Boolean;
    blnAcesso: Boolean;
    objFechamento: TFechamentoFinanceiro;

    FEmpresaCadastroMovimento : String;

    FRegistroCTPDETFrete,
    FRegistroCTPDETAjuste: TArrBaiSinCar;

    procedure pCarregaCartao;
    procedure pCarregaEmpresa;
    function FechamentoFinanceiroJaRealizado:Boolean;
    Function fEstornaCartao(strAutoInc: String;
                            strChaCon : String = '';
                            strAutoIncLogMca: String = ''): Boolean;
    Function fEstorna: Boolean;
    function fEstornaCartoes(pgbStatus: TcxProgressBar): Boolean;

    procedure AtualizaCampoConcilMercadoLivre(ARegistros: TDataset);

    procedure pCarregaQuerys;
    procedure pExecutaConsulta;

    procedure pCriaAggrFields;

    procedure pAtualizaTotalizadores;

    Procedure pDesmarcar;

    function fRetOperadora(strChaCon: String): String;
    function fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;

    procedure GeraRegistroCTPDetDeTaxaParaMarketPlace(cdsRegistro: TUniClientDataset);

    function ValidaGravacaoCTPDet(out AGravarFrete: Boolean;
                                  out AGravarAjuste: Boolean;
                                  APlanoDeContas: String): Boolean;

    procedure GravaCTPDetDeTaxaParaMarketPlaceAnalitico(ANumeroDuplicata,
                                                        ACodigoFornecedor,
                                                        ACodigoEmpresa,
                                                        ASerie,
                                                        APlanoDeContas,
                                                        AEventoTaxa: String;
                                                        AValorTotalTaxa: Double);

     function CartoesJaEstornadoEmOutraEstacao: Boolean;
  public
    { Public declarations }
    qryGenCar: TUniQuery;
    property EmpresaCadastroMovimento : String read FEmpresaCadastroMovimento write FEmpresaCadastroMovimento;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; override;
    function fSetParametros: Boolean; override;
    procedure pAddListaQuery; override;
    procedure pAcaoAdd; override;
    procedure pAcaoDel; override;
    function fInLista(strValor: String): Boolean; Reintroduce; Overload;
  end;


implementation

{$R *.dfm}

Uses untFuncoes, untFuncoesSimples, untPai, untMovBan, untCadPag,untPesqAux,
  untGravando, untTBanMca, untLogMca, untTEstornaCartoes, untTMovBanRepository;

procedure TfrmEstornaCartoes.pCarregaQuerys;
Var
    strSQL   : String;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  MOVCAR ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  MCA_VALORI = IF(MCA_VALANT <> 0.00, MCA_VALANT, MCA_VALORI), ';
  strSQL := strSQL + '  MCA_VALDUP = MCA_VALORI, ';
  strSQL := strSQL + '  MCA_FREMKT = MCA_FREANT, ';
  strSQL := strSQL + '  MCA_CUPMKT = MCA_CUPANT, ';
  strSQL := strSQL + '  MCA_VALSTA = IF(IFNULL(MCA_BRUANT, 0.00) <> 0.00, MCA_BRUANT, MCA_VALSTA), ';
  strSQL := strSQL + '  MCA_DTAREC = NULL, ';
  strSQL := strSQL + '  MCA_VALREC = NULL, ';
  strSQL := strSQL + '  MCA_PERCAR = IF(MCA_VALANT = 0.00, (SELECT IF(UPPER(CAR_TIPTAX)="P", CAR_PERDES, ';
  strSQL := strSQL + '               ROUND((MCA_VALTAX / MCA_VALSTA) * 100, 6))  FROM CADCAR WHERE CAR_CODCAR = MCA_CODCAR LIMIT 1), ';
  strSQL := strSQL + '  ROUND((MCA_TAXANT / MCA_VALSTA) * 100, 6)), ';
  strSQL := strSQL + '  MCA_VALTAX = IF(MCA_VALANT = 0.00, ROUND((MCA_PERCAR*MCA_VALSTA)/100,2),';
  strSQL := strSQL + '  MCA_TAXANT), ';
  strSQL := strSQL + '  MCA_OPEBAI = NULL, ';
  strSQL := strSQL + '  MCA_HISBAI = NULL, ';
  strSQL := strSQL + '  MCA_PORBAI = NULL, ';
  strSQL := strSQL + '  MCA_CTABAI = NULL, ';
  strSQL := strSQL + '  MCA_PORBTX = NULL, ';
  strSQL := strSQL + '  MCA_DTABAN = NULL, ';
  strSQL := strSQL + '  MCA_CTABTX = NULL, ';
  strSQL := strSQL + '  MCA_DOCBTX = NULL, ';
  strSQL := strSQL + '  MCA_DOCBAN = NULL, ';
  strSQL := strSQL + '  MCA_CTADEB = NULL, ';
  strSQL := strSQL + '  MCA_PORDEB = NULL, ';
  strSQL := strSQL + '  MCA_FORBTX = NULL, ';
  strSQL := strSQL + '  MCA_VALANT = 0.00, ';
  strSQL := strSQL + '  MCA_TAXANT = 0.00, ';
  strSQL := strSQL + '  MCA_ANTTAX = 0.00, ';
  strSQL := strSQL + '  MCA_VALAJU = 0.00, ';
  strSQL := strSQL + '  MCA_FREANT = 0.00, ';
  strSQL := strSQL + '  MCA_CUPANT = 0.00, ';
  strSQL := strSQL + '  MCA_BRUANT = 0.00, ';
  strSQL := strSQL + '  MCA_DOCDEB = NULL, ';
  strSQL := strSQL + '  MCA_CHACON = NULL, ';
  strSQL := strSQL + '  MCA_DTABAI = NULL, ';
  strSQL := strSQL + '  MCA_EVECRE = NULL, ';
  strSQL := strSQL + '  MCA_EVETAX = NULL, ';
  strSQL := strSQL + '  MCA_EVEDEB = NULL, ';
  strSQL := strSQL + '  MCA_DOCANT = NULL, ';
  strSQL := strSQL + '  MCA_CTAANT = NULL, ';
  strSQL := strSQL + '  MCA_DOCFRE = NULL, ';
  strSQL := strSQL + '  MCA_DOCAJU = NULL, ';
  strSQL := strSQL + '  MCA_DOCCUP = NULL  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTOIN';

  qryEstCar := fCriaQuery(Self);
  qryEstCar.Close;
  qryEstCar.SQL.Text := strSQL;
end;

procedure TfrmEstornaCartoes.pCarregaCartao;
begin
  pPesquisaCadCar(qryCadCar, qryCadCar, edtCodCar.Text);
  With qryCadCar Do
  Begin
    edtDesCar.Text := FieldByName('CAR_DESCAR').AsString;

    If (Length(arrCartao) > 1) Then
      edtDesCar.Text := '+1';
  End;
end;

procedure TfrmEstornaCartoes.pCarregaEmpresa;
Begin
  pPesquisaCadEmp(qryCadEmp, qryCadEmp, edtCodEmp.Text);
  With qryCadEmp Do
  Begin
    edtDesEmp.Text := FieldByName('EMP_NOMEMP').AsString;

    If (Length(arrEmp) > 1) Then
      edtDesEmp.Text := '+1';
  End;
end;

function TfrmEstornaCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCar) Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        edtDesCar.Text := 'TODAS';
      End
      Else
      Begin
        pDesmarcaLista(edtCodCar, arrCartao);
        pCarregaCartao;
        If (Length(arrCartao) <= 0) And (qryCadCar.FieldbyName('CAR_CODCAR').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cartão não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Not blnAcesso Then
          Begin
            If (Length(arrCartao) <= 0) And (Not fVerificaAcessoCartao(edtCodCar.Text)) Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End
    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
        mskDtaFin.Clear;
      End
      Else
      Begin
        If StrToDateDef(mskDtaIni.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data Inicial informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
          mskDtaFin.Enabled := True;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToDateDef(mskDtaFin.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data Final informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtTipoData) Then
    Begin

      If Pos(edtTipoData.Text,'V_C_B_R_') <= 0 Then
      Begin
        fMensagem('', 'O campo Data de deve ser V, C, B ou R! ', ['&O k']);

        Result := False;
      End

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtDesEmp.Text := 'TODAS';
      End
      Else
      Begin
        pDesmarcaLista(edtCodEmp, arrEmp);
        pCarregaEmpresa;
        If (Length(arrEmp) <= 0) And (qryCadEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not blnAcesso) And (Length(arrEmp) <= 0) And (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = edtData) And (edtData.Visible) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(edtData.Text)) Then
      Begin
        If StrToDateDef(edtData.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data da Pesquisa informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEstornaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(
  cdsRegistro: TUniClientDataset);
begin
  FRegistroCTPDetFrete.strCodEmp := '';
  FRegistroCTPDetAjuste.strCodEmp := '';

  If cdsRegistro.FieldByName('CAR_MKTPLA').AsString = 'N' Then
    Exit;

  If Not cdsRegistro.FieldByName('CAR_CTAFRE').AsString.IsEmpty Then
  Begin
    If cdsRegistro.FieldByName('MCA_FREMKT').AsFloat <> 0 Then
    Begin
      FRegistroCTPDetFrete.strCodEmp := IIF(cdsRegistro.FieldByName('MCA_EMPBAI').IsNull,
                                            VS_strCodEmp,
                                            cdsRegistro.FieldByName('MCA_EMPBAI').AsString);

      FRegistroCTPDetFrete.dtaDtaRec := cdsRegistro.FieldByName('MCA_DTAREC').AsDateTime;
      FRegistroCTPDetFrete.strPorTax := cdsRegistro.FieldByName('MCA_PORBTX').AsString;
      FRegistroCTPDetFrete.strCtaTax := cdsRegistro.FieldByName('CAR_CTAFRE').AsString;
      FRegistroCTPDetFrete.strEventoTaxa := cdsRegistro.FieldByName('MCA_EVETAX').AsString;
      FRegistroCTPDetFrete.fltValTax := cdsRegistro.FieldByName('MCA_FREMKT').AsFloat;
    End;
  End;

  If Not cdsRegistro.FieldByName('CAR_CTAAJU').AsString.IsEmpty Then
  Begin
    If cdsRegistro.FieldByName('MCA_VALAJU').AsFloat <> 0 Then
    Begin
      FRegistroCTPDetAjuste.strCodEmp := IIF(cdsRegistro.FieldByName('MCA_EMPBAI').IsNull,
                                             VS_strCodEmp,
                                             cdsRegistro.FieldByName('MCA_EMPBAI').AsString);

      FRegistroCTPDetAjuste.dtaDtaRec := cdsRegistro.FieldByName('MCA_DTAREC').AsDateTime;
      FRegistroCTPDetAjuste.strPorTax := cdsRegistro.FieldByName('MCA_PORBTX').AsString;
      FRegistroCTPDetAjuste.strCtaTax := cdsRegistro.FieldByName('CAR_CTAAJU').AsString;
      FRegistroCTPDetAjuste.strEventoTaxa := cdsRegistro.FieldByName('MCA_EVETAX').AsString;
      FRegistroCTPDetAjuste.fltValTax := cdsRegistro.FieldByName('MCA_VALAJU').AsFloat;
    End;
  End;
end;

procedure TfrmEstornaCartoes.GravaCTPDetDeTaxaParaMarketPlaceAnalitico(
  ANumeroDuplicata, ACodigoFornecedor, ACodigoEmpresa, ASerie, APlanoDeContas,
  AEventoTaxa: String; AValorTotalTaxa: Double);
  Var
    LValorResidual: Double;

    LInsert: TUniQuery;

    LGravarFrete,
    LGravarAjuste,
    LGravarCTPDet: Boolean;
begin
  If Not ValidaGravacaoCTPDet(LGravarFrete, LGravarAjuste, APlanoDeContas) Then
    Exit;

  LValorResidual := Abs(AValorTotalTaxa);

  LInsert := fCriarQuery('SELECT * FROM CTPDET WHERE FALSE');
  LInsert.Open;

  LGravarCTPDet := False;

  Try
    If LGravarFrete Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := FRegistroCTPDetFrete.strCtaTax;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not FRegistroCTPDetFrete.strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := FRegistroCTPDetFrete.strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(FRegistroCTPDetFrete.fltValTax) / Abs(AValorTotalTaxa);
      LInsert.Post;

      LValorResidual := fFormataFloat(LValorResidual - Abs(FRegistroCTPDetFrete.fltValTax), 2);

      LGravarCTPDet := True;
    End;

    If LGravarAjuste Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := FRegistroCTPDetAjuste.strCtaTax;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not FRegistroCTPDetAjuste.strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := FRegistroCTPDetAjuste.strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(FRegistroCTPDetAjuste.fltValTax) / Abs(AValorTotalTaxa);
      LInsert.Post;

      LValorResidual := fFormataFloat(LValorResidual - Abs(FRegistroCTPDetAjuste.fltValTax), 2);

      LGravarCTPDet := True;
    End;

    If LGravarCTPDet Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := APlanoDeContas;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not AEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := AEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(LValorResidual) / Abs(AValorTotalTaxa);
      LInsert.Post;
    End;
  Finally
    FreeAndNil(LInsert);
  End;
end;

function TfrmEstornaCartoes.fEstornaCartao(strAutoInc: String;
                                           strChaCon : String = '';
                                           strAutoIncLogMca: String = ''): Boolean;
begin
  Try
    Result := True;

    qryEstCar.Close;
    qryEstCar.ParamByName('AUTOIN').AsString := strAutoInc;
    qryEstCar.ExecSQL;
    qryEstCar.Close;

    untLogMca.GravaLogMca(strAutoInc,
                          'ESTORNO DE CARTÕES (' + fRetOperadora(strChaCon) + ')',
                          Self.Name,
                          strAutoIncLogMca);

    If MatchStr(LeftStr(strChaCon, 4), ['MER_']) Then
      AtualizaCampoConcilMercadoLivre(cdsConsulta);
  Except
    On E: Exception Do
      Raise Exception.Create('Erro ao estornar Movimento de Cartão de Crédito: ' + E.Message);
  End;

end;

function TfrmEstornaCartoes.fRetOperadora(strChaCon: String): String;
Begin
  If fEmptyStr(strChaCon) Then
    Result := 'BAIXA MANUAL'
  Else
  Begin
    Result := 'Conciliação (';
    If LeftStr(strChaCon, 4) = 'RED_' Then
      Result := Result + 'REDECARD)'
    Else If LeftStr(strChaCon, 4) = 'CIE_' Then
      Result := Result + 'CIELO)'
    Else If LeftStr(strChaCon, 4) = 'CHA_' Then
      Result := Result + 'CHART-CIELO)'
    Else If LeftStr(strChaCon, 4) = 'EQU_' Then
      Result := Result + 'EQUALS)'
    Else If LeftStr(strChaCon, 4) = 'ELA_' Then
      Result := Result + 'ELAVON)'
    Else If LeftStr(strChaCon, 4) = 'CON_' Then
      Result := Result + 'CONCIL)'
    Else If LeftStr(strChaCon, 4) = 'AME_' Then
      Result := Result + 'AMEX)'
    Else If LeftStr(strChaCon, 4) = 'STO_' Then
      Result := Result + 'STONE)'
    Else If LeftStr(strChaCon, 4) = 'SIP_' Then
      Result := Result + 'SIPAG)'
    Else If LeftStr(strChaCon, 4) = 'SAF_' Then
      Result := Result + 'SAFRAPAY)'
    Else If LeftStr(strChaCon, 4) = 'MER_' Then
      Result := Result + 'MERCADO LIVRE)'
    Else If LeftStr(strChaCon, 4) = 'WAL_' Then
      Result := Result + 'WALMART)'
    Else If LeftStr(strChaCon, 4) = 'B2W_' Then
      Result := Result + 'B2W)'
    Else If LeftStr(strChaCon, 4) = 'SIC_' Then
      Result := Result + 'SICREDI)'
    Else If LeftStr(strChaCon, 4) = 'GRA_' Then
      Result := Result + 'GRANITO)'
    Else If LeftStr(strChaCon, 4) = 'BIN_' Then
      Result := Result + 'FISERVBIN)'
    Else
      Result := Result + 'GETNET)';
  End;
End;

function TfrmEstornaCartoes.fEstornaCartoes(pgbStatus: TcxProgressBar): Boolean;
  Var
    intIndex : Integer;
    strSeqLan,
    strHisDoc,
    strSeqLanTax,
    strSeqLanAnt: String;
    intCtpCon: Integer;
    strNumDup: String;
    dtaEstorn: TDateTime;
    repMovBan: TMovBanRepository;

    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorDebito: Double;

    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;
begin
  Result := false;

  pgbStatus.Position       := 0;
  pgbStatus.Properties.Max := stlListSelecao.Count;

  Try
    {*****************************************}
    {* PROCESSA AS DUPLICATAS MARCADAS       *}
    {**************************************LA*}
    fAbrirTabela(qryCadPag);

    With cdsConsulta Do
    Begin
      DisableControls;

      fStartTransaction;
      intCtpCon := fRetCtpCon;
      fCommit;

      objSequencias := TEstornaCartoes.RetornaSequenciaisParaEstornoAnalitico(cdsConsulta);
      objSequencias.SequencialControleBaixaPagar := intCtpCon;

      {******************************}
      {* INICIO TRANSAÇÃO PRINCIPAL *}
      {***************************AJ*}
      fStartTransaction;
      Filter   := '';
      Filtered := False;
      For intIndex := 0 To stlListSelecao.Count - 1 Do
      Begin
        strSeqLan    := '';
        strSeqLanTax := '';
        strSeqLanAnt := '';
        If Not Locate('AUTOINCREM',Copy(stlListSelecao[intIndex],2,20),[]) Then
        Begin
          fRollBack;
          fMensagem('','Registro não localizado.',['&OK']);
          Break;
        End;

        If blnDtaDoc Then
          dtaEstorn := FieldByName('MCA_DTAREC').AsDateTime
        Else
          dtaEstorn := VS_Date;

        strHisDoc := 'Est. ' + FieldByName('CAR_DESCAR').AsString;

        LBanMcaDS := TBanMcaDS.Create;
        LBanMcaDS.strNumDup := cdsConsulta.FieldByName('NRODUP').AsString;
        LBanMcaDS.strParcel := cdsConsulta.FieldByName('PARDUP').AsString;
        LBanMcaDS.strCodEmp := cdsConsulta.FieldByName('MCA_CODEMP').AsString;
        LBanMcaDS.strCodCli := cdsConsulta.FieldByName('MCA_CODCLI').AsString;
        LBanMcaDS.strCodCar := cdsConsulta.FieldByName('MCA_CODCAR').AsString;
        LBanMcaDS.strHist01 := cdsConsulta.FieldByName('MCA_HIST01').AsString;
        LBanMcaDS.strHist02 := cdsConsulta.FieldByName('MCA_HIST02').AsString;
        LBanMcaDS.strNumCCD := cdsConsulta.FieldByName('MCA_NUMCCD').AsString;
        LBanMcaDS.strNumNsu := cdsConsulta.FieldByName('MCA_NUMNSU').AsString;
        LBanMcaDS.fltValSta := cdsConsulta.FieldByName('MCA_VALSTA').AsFloat;
        LBanMcaDS.fltValTax := cdsConsulta.FieldByName('MCA_VALTAX').AsFloat;
        LBanMcaDS.fltValRec := cdsConsulta.FieldByName('MCA_VALREC').AsFloat;
        LBanMcaDS.fltFreMkt := cdsConsulta.FieldByName('MCA_FREMKT').AsFloat;
        LBanMcaDS.fltValAju := cdsConsulta.FieldByName('MCA_VALAJU').AsFloat;
        LBanMcaDS.fltCupMkt := cdsConsulta.FieldByName('MCA_CUPMKT').AsFloat;
        LBanMcaDS.strIdenti := 'VALSTA';
        LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

        Inc(objSequencias.intContadorAutIncBanMca);

        LListaBanMca := TListaBanMCA.Create;
        LListaBanMca.Add(LBanMcaDS);

        {*****************************************************}
        {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
        {*REQ*155872***************************************MO*}
        repMovBan := TMovBanRepository.Create;
        repMovBan.pLimparOrigemPrincipal(FieldByName('MCA_DOCBAN').AsString);
        FreeAndNil(repMovBan);

        LValorDebito := cdsConsulta.FieldByName('MCA_VALSTA').AsFloat;
        If cdsConsulta.FieldByName('MCA_DOCCUP').AsString.IsEmpty Then
          LValorDebito := LValorDebito + cdsConsulta.FieldByName('MCA_CUPMKT').AsFloat;

        {*****************************************}
        {* GRAVA MOVBAN DO CARTÃO                *}
        {**************************************LA*}
        strSeqLan   := fGravaMovBan(FieldByName('MCA_CTABAI').AsString,   // Centro de Custo
                                    FieldByName('MCA_PORBAI').AsString,   // Portador
                                    strLoginUsuarioLogado,                // Operador
                                    dtaEstorn,                            // Data do Lançamento
                                    fTime(),                              // Hora do Lançamento
                                    '',                                   // Documento
                                    'D',                                  // Credito / Debito
                                    IIF(FieldByName('MCA_EMPBAI').IsNull,
                                        VS_strCodEmp,
                                        FieldByName('MCA_EMPBAI').AsString), // Empresa
                                    LValorDebito,                         // Valor Documento
                                    strHisDoc,                            // Historico 1
                                    '',                                   // Historico 2
                                    FieldByName('MCA_CODCLI').AsString,   // Cliente
                                    '',                                   // Fornecedor
                                    '',                                   // Numero da Duplicata
                                    0,                                    // Sequencial Duplicata
                                    '',                                   // Parcela da Duplicata
                                    '',                                   // Empresa da Duplicata
                                    '',                                   // Série
                                    FieldByName('MCA_EVECRE').AsString,   // Código do Evento
                                    '',                                   // Documento da Baixa
                                    Nil,                                  // Log Bancário
                                    0,
                                    intCtpCon,
                                    '',
                                    '',
                                    objSequencias.intSeqLan.ToString,
                                    fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                    '',
                                    '',
                                    1,
                                    False,
                                    LListaBanMca);

        Inc(objSequencias.intSeqLan);
        Inc(objSequencias.intContadorAutIncMovBan);

        Result := (Not fEmptyStr(strSeqLan));

        If (Result) And
           (Not fEmptyStr(FieldByName('MCA_PORDEB').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_CTADEB').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_DOCDEB').AsString)) Then
        Begin
          LBanMcaDS.strIdenti := 'VALSTA';
          LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

          Inc(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          {*****************************************************}
          {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
          {*REQ*155872***************************************MO*}
          repMovBan := TMovBanRepository.Create;
          repMovBan.pLimparOrigemPrincipal(FieldByName('MCA_DOCDEB').AsString);
          FreeAndNil(repMovBan);

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO                *}
          {**************************************LA*}
          strSeqLan   := fGravaMovBan(FieldByName('MCA_CTADEB').AsString,   // Centro de Custo
                                      FieldByName('MCA_PORDEB').AsString,   // Portador
                                      strLoginUsuarioLogado,                // Operador
                                      dtaEstorn,                            // Data do Lançamento
                                      fTime(),                              // Hora do Lançamento
                                      '',                                   // Documento
                                      'C',                                  // Credito / Debito
                                      IIF(FieldByName('MCA_EMPBAI').IsNull,
                                          VS_strCodEmp,
                                          FieldByName('MCA_EMPBAI').AsString), // Empresa
                                      FieldByName('MCA_VALSTA').AsFloat +
                                        FieldByName('MCA_CUPMKT').AsFloat,    // Valor Documento
                                      strHisDoc,                            // Historico 1
                                      '',                                   // Historico 2
                                      FieldByName('MCA_CODCLI').AsString,   // Cliente
                                      '',                                   // Fornecedor
                                      '',                                   // Numero da Duplicata
                                      0,                                    // Sequencial Duplicata
                                      '',                                   // Parcela da Duplicata
                                      '',                                   // Empresa da Duplicata
                                      '',                                   // Série
                                      FieldByName('MCA_EVEDEB').AsString,   // Código do Evento
                                      '',                                   // Documento da Baixa
                                      Nil,                                  // Log Bancário
                                      0,
                                      intCtpCon,
                                      '',
                                      '',
                                      objSequencias.intSeqLan.ToString,
                                      fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                      '',
                                      '',
                                      1,
                                      False,
                                      LListaBanMca);

          Inc(objSequencias.intSeqLan);
          Inc(objSequencias.intContadorAutIncMovBan);

          Result := (Not fEmptyStr(strSeqLan));
        End;

        {***************************************}
        {* TRATAMENTO DO ESTORNO DA TAXA       *}
        {************************************LA*}
        If (Result) And
           (Not fEmptyStr(FieldByName('MCA_PORBTX').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_CTABTX').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_VALTAX').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_DOCBTX').AsString)) And
           (FieldByName('MCA_VALTAX').AsFloat > 0) Then
        Begin
          LBanMcaDS.strIdenti := 'VALTAX';
          LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

          Inc(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          {*****************************************************}
          {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
          {*REQ*155872***************************************MO*}
          repMovBan := TMovBanRepository.Create;
          repMovBan.pLimparOrigemPrincipal(FieldByName('MCA_DOCBTX').AsString);
          FreeAndNil(repMovBan);

          LValorTotalTaxa := FieldByName('MCA_VALTAX').AsFloat -
                             FieldByName('MCA_ANTTAX').AsFloat;

          If FieldByName('MCA_DOCFRE').AsString.IsEmpty Then
            LValorTotalTaxa := LValorTotalTaxa +
                               Abs(FieldByName('MCA_FREMKT').AsFloat);

          If FieldByName('MCA_DOCAJU').AsString.IsEmpty Then
            LValorTotalTaxa := LValorTotalTaxa +
                               Abs(FieldByName('MCA_VALAJU').AsFloat);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA                  *}
          {**************************************LA*}
          strSeqLanTax := fGravaMovBan(FieldByName('MCA_CTABTX').AsString,   // Centro de Custo
                                       FieldByName('MCA_PORBTX').AsString,   // Portador
                                       strLoginUsuarioLogado,                // Operador
                                       dtaEstorn,                            // Data do Lançamento
                                       fTime(),                              // Hora do Lançamento
                                       '',                                   // Documento
                                       'C',                                  // Credito / Debito
                                       IIF(FieldByName('MCA_EMPBAI').IsNull,
                                           VS_strCodEmp,
                                           FieldByName('MCA_EMPBAI').AsString), // Empresa
                                       LValorTotalTaxa,                       // Valor Documento
                                       'Est. de Taxas Ref. Aos Cartões',     // Historico 1
                                       '',                                   // Historico 2
                                       FieldByName('MCA_CODCLI').AsString,   // Cliente
                                       FieldByName('MCA_FORBTX').AsString,   // Fornecedor
                                       '',                                   // Numero da Duplicata
                                       0,                                    // Sequencial Duplicata
                                       '',                                   // Parcela da Duplicata
                                       '',                                   // Empresa da Duplicata
                                       '',                                   // Série
                                       FieldByName('MCA_EVETAX').AsString,   // Código do Evento
                                       '',                                   // Documento da Baixa
                                       Nil,                                  // Log Bancário
                                       0,
                                       intCtpCon,
                                       '',

                                       '',
                                       objSequencias.intSeqLan.ToString,
                                       fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                       '',
                                       '',
                                       1,
                                       False,
                                       LListaBanMca);

          Inc(objSequencias.intSeqLan);
          Inc(objSequencias.intContadorAutIncMovBan);

          Result := (Not fEmptyStr(strSeqLanTax));
        End;

        {************************}
        {* GRAVA CADPAG DA TAXA *}
        {*********************LA*}
        If (Result) And
           (Not fEmptyStr(strSeqLanTax)) And
           (Not fEmptyStr(FieldByName('MCA_FORBTX').AsString)) Then
        Begin
          objSequencias.intSequencialCadPag := Copy(fRetSequencialCadPag(1, IIF(FieldByName('MCA_EMPBAI').IsNull,
                                                                                VS_strCodEmp,
                                                                                FieldByName('MCA_EMPBAI').AsString)), 2).ToInt64;
          strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

          LValorTotalTaxa := FieldByName('MCA_VALTAX').AsFloat -
                             FieldByName('MCA_ANTTAX').AsFloat +
                             Abs(FieldByName('MCA_FREMKT').AsFloat) +
                             Abs(FieldByName('MCA_VALAJU').AsFloat);

          Result  := fGravaCadPag('frmEstornaCartoes',    //Nome Form LOGCTP
                                  'ESTORNO DE CARTOES',   //Descrição LOGCTP
                                  FieldByName('MCA_FORBTX').AsString,
                                  strNumDup,
                                  'A',
                                  IIF(FieldByName('MCA_EMPBAI').IsNull,
                                      VS_strCodEmp,
                                      FieldByName('MCA_EMPBAI').AsString), // Empresa,
                                  FieldByName('MCA_CTABTX').AsString,
                                  'CRT',
                                  0,
                                  dtaEstorn,
                                  dtaEstorn,
                                  0,
                                  -(LValorTotalTaxa),
                                  'N',
                                  'N',
                                  'N',                                            // Deposito
                                  'Est. de Taxas Ref. Aos Cartões',
                                  '',
                                  'Est. de Taxas Ref. Aos Cartões',
                                  FieldByName('MCA_PORBTX').AsString,
                                  FieldByName('MCA_CTABTX').AsString,
                                  strSeqLanTax,
                                  strLoginUsuarioLogado,
                                  dtaEstorn,
                                  -(LValorTotalTaxa),
                                  0,
                                  0,
                                  VS_strCodEmp,
                                  FieldByName('MCA_EVETAX').AsString,
                                  '',
                                  FieldByName('MCA_PORBTX').AsString,
                                  '',
                                  0.0,
                                  0.0,
                                  intCtpCon,
                                  False,
                                  0,
                                  '',
                                  0,
                                  '',
                                  '',
                                  '',
                                  '',
                                  fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  -(LValorTotalTaxa),
                                  0,
                                  0,
                                  0,
                                  '',
                                  0,
                                  0,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '0',
                                  '',
                                  '',
                                  fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

          Inc(objSequencias.intContadorAutIncCadPag);
          Inc(objSequencias.intContadorAutIncLogCtp);
          objSequencias.intSequencialCadPag := Copy(fRetSequencialCadPag(1, IIF(FieldByName('MCA_EMPBAI').IsNull,
                                                                                VS_strCodEmp,
                                                                                FieldByName('MCA_EMPBAI').AsString)), 2).ToInt64;
          Result := (Not fEmptyStr(strSeqLan)) And Result;

          If Not Result Then
            Break;

          GeraRegistroCTPDetDeTaxaParaMarketPlace(cdsConsulta);
          GravaCTPDetDeTaxaParaMarketPlaceAnalitico(strNumDup,
                                                    FieldByName('MCA_FORBTX').AsString,
                                                    IIF(FieldByName('MCA_EMPBAI').IsNull,
                                                        VS_strCodEmp,
                                                        FieldByName('MCA_EMPBAI').AsString),
                                                    'CRT',
                                                    FieldByName('MCA_CTABTX').AsString,
                                                    FieldByName('MCA_EVETAX').AsString,
                                                    -(LValorTotalTaxa));

        End;

        {************************************************}
        {* TRATAMENTO DO ESTORNO DA TAXA DE ANTECIPAÇÃO *}
        {*********************************************AJ*}
        If (Result) And
           (Not fEmptyStr(FieldByName('MCA_PORBTX').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_CTAANT').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_ANTTAX').AsString)) And
           (Not fEmptyStr(FieldByName('MCA_DOCANT').AsString)) And
           (FieldByName('MCA_ANTTAX').AsFloat > 0) Then
        Begin
          LBanMcaDS.strIdenti := 'ANTTAX';
          LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

          Inc(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          {*****************************************************}
          {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
          {*REQ*155872***************************************MO*}
          repMovBan := TMovBanRepository.Create;
          repMovBan.pLimparOrigemPrincipal(FieldByName('MCA_DOCANT').AsString);
          FreeAndNil(repMovBan);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO   *}
          {**************************************AJ*}
          strSeqLanAnt := fGravaMovBan(FieldByName('MCA_CTAANT').AsString,   // Centro de Custo
                                       FieldByName('MCA_PORBTX').AsString,   // Portador
                                       strLoginUsuarioLogado,                // Operador
                                       dtaEstorn,                            // Data do Lançamento
                                       fTime(),                              // Hora do Lançamento
                                       '',                                   // Documento
                                       'C',                                  // Credito / Debito
                                       IIF(FieldByName('MCA_EMPBAI').IsNull,
                                           VS_strCodEmp,
                                           FieldByName('MCA_EMPBAI').AsString), // Empresa
                                       FieldByName('MCA_ANTTAX').AsFloat,    // Valor Documento
                                       'Est. de Tx Antecip. Ref. Aos Cartões',     // Historico 1
                                       '',                                   // Historico 2
                                       FieldByName('MCA_CODCLI').AsString,   // Cliente
                                       FieldByName('MCA_FORBTX').AsString,   // Fornecedor
                                       '',                                   // Numero da Duplicata
                                       0,                                    // Sequencial Duplicata
                                       '',                                   // Parcela da Duplicata
                                       '',                                   // Empresa da Duplicata
                                       '',                                   // Série
                                       '',                                   // Código do Evento
                                       '',                                   // Documento da Baixa
                                       Nil,                                  // Log Bancário
                                       0,
                                       intCtpCon,
                                       '',

                                       '',
                                       objSequencias.intSeqLan.ToString,
                                       fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                       '',
                                       '',
                                       1,
                                       False,
                                       LListaBanMca);

          Inc(objSequencias.intSeqLan);
          Inc(objSequencias.intContadorAutIncMovBan);

          Result := (Not fEmptyStr(strSeqLanAnt));
        End;

        {***************************************}
        {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
        {************************************AJ*}
        If (Result) And
           (Not fEmptyStr(strSeqLanAnt)) And
           (Not fEmptyStr(FieldByName('MCA_FORBTX').AsString)) Then
        Begin
          objSequencias.intSequencialCadPag := Copy(fRetSequencialCadPag(1, IIF(FieldByName('MCA_EMPBAI').IsNull,
                                                                                VS_strCodEmp,
                                                                                FieldByName('MCA_EMPBAI').AsString)), 2).ToInt64;
          strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);;

          Result  := fGravaCadPag('frmEstornaCartoes',    //Nome Form LOGCTP
                                  'ESTORNO DE CARTOES',   //Descrição LOGCTP
                                  FieldByName('MCA_FORBTX').AsString,
                                  strNumDup,
                                  'A',
                                  IIF(FieldByName('MCA_EMPBAI').IsNull,
                                      VS_strCodEmp,
                                      FieldByName('MCA_EMPBAI').AsString), // Empresa
                                  FieldByName('MCA_CTAANT').AsString,
                                  'CRT',
                                  0,
                                  dtaEstorn,
                                  dtaEstorn,
                                  0,
                                  -FieldByName('MCA_ANTTAX').AsFloat,
                                  'N',
                                  'N',
                                  'N',                                            // Deposito
                                  'Est. de Tx Antecip. Ref. Aos Cartões',
                                  '',
                                  'Est. de Tx Antecip. Ref. Aos Cartões',
                                  FieldByName('MCA_PORBTX').AsString,
                                  FieldByName('MCA_CTAANT').AsString,
                                  strSeqLanTax,
                                  strLoginUsuarioLogado,
                                  dtaEstorn,
                                  -FieldByName('MCA_ANTTAX').AsFloat,
                                  0,
                                  0,
                                  VS_strCodEmp,
                                  '',
                                  '',
                                  '',
                                  '',
                                  0.0,
                                  0.0,
                                  intCtpCon,
                                  False,
                                  0,
                                  '',
                                  0,
                                  '',
                                  '',
                                  '',
                                  '',
                                  fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  -FieldByName('MCA_ANTTAX').AsFloat,
                                  0,
                                  0,
                                  0,
                                  '',
                                  0,
                                  0,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '0',
                                  '',
                                  '',
                                  fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

          Inc(objSequencias.intContadorAutIncCadPag);
          Inc(objSequencias.intContadorAutIncLogCtp);
          objSequencias.intSequencialCadPag := Copy(fRetSequencialCadPag(1, IIF(FieldByName('MCA_EMPBAI').IsNull,
                                                                                VS_strCodEmp,
                                                                                FieldByName('MCA_EMPBAI').AsString)), 2).ToInt64;

          Result := (Not fEmptyStr(strSeqLanAnt)) And Result;

          If Not Result Then
            Break;

        End;

        repMovBan := TMovBanRepository.Create;
        repMovBan.pLimparOrigemPrincipal(cdsConsulta.FieldByName('MCA_DOCFRE').AsString);
        repMovBan.pLimparOrigemPrincipal(cdsConsulta.FieldByName('MCA_DOCAJU').AsString);
        repMovBan.pLimparOrigemPrincipal(cdsConsulta.FieldByName('MCA_DOCCUP').AsString);
        FreeAndNil(repMovBan);

        TEstornaCartoes.GravarMovBanAnalitoFreteTaxasMarketPlace(cdsConsulta,
                                                                 objSequencias,
                                                                 dtaEstorn);

        If Result Then
        Begin
          Result      := fEstornaCartao(FieldByName('AUTOINCREM').AsString,
                                        FieldByName('MCA_CHACON').AsString,
                                        fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_strCodEmp));

          Inc(objSequencias.intContadorAutIncLogMca);
        End;
        pStepStatusGravacao(pgbStatus);
      End; {For}

      fFecharTabela(qryCadPag);

      EnableControls;
    End;
  Except
    On E: Exception Do
    Begin
			Raise Exception.Create(E.Message);
    End;
  End;

  If Assigned(LListaBanMca) Then
    FreeAndNil(LListaBanMca);
  blnBaixad := Result;
end;

procedure TfrmEstornaCartoes.pAtualizaTotalizadores;
begin
  edtQtdGer.Text := '0';
  edtValGer.Text := '0,00';
  edtQtdSel.Text := '0';
  edtValSel.Text := '0,00';

  With cdsConsulta Do
  Begin
    If (Active) And (Not IsEmpty) Then
    Begin
      edtQtdGer.Text := InttoStr(RecordCount);
      edtValGer.Text := FormatFloat('###,##0.00', TAggregateField(FieldByName('TOT_VALTOT')).Value);
      edtQtdSel.Text := TAggregateField(FieldByName('TOT_SELQTD')).AsString;
      edtValSel.Text := FormatFloat('###,##0.00', TAggregateField(FieldByName('TOT_SELTOT')).Value);
    End;
  End;
end;

procedure TfrmEstornaCartoes.pExecutaConsulta;
begin
  //Feito para poder usar a untGravando
  Application.ProcessMessages;
  fAbreConsulta(True);

  pAtualizaTotalizadores;
end;

function TfrmEstornaCartoes.ValidaGravacaoCTPDet(out AGravarFrete,
  AGravarAjuste: Boolean; APlanoDeContas: String): Boolean;
begin
  AGravarFrete := Not FRegistroCTPDetFrete.strCodEmp.IsEmpty;
  If AGravarFrete Then
    AGravarFrete := FRegistroCTPDetFrete.strCtaTax <> APlanoDeContas;

  AGravarAjuste := Not FRegistroCTPDetAjuste.strCodEmp.IsEmpty;
  If AGravarAjuste Then
    AGravarAjuste := FRegistroCTPDetAjuste.strCtaTax <> APlanoDeContas;

  Result := AGravarFrete;
  If Not Result Then
    Result := AGravarAjuste;
end;

procedure TfrmEstornaCartoes.pCriaAggrFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTOT';
    FieldName     := 'TOT_VALTOT';
    DataSet       := cdsConsulta;
    Expression    := 'SUM(MCA_VALTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELTOT';
    FieldName     := 'TOT_SELTOT';
    DataSet       := cdsConsulta;
    Expression    := 'SUM(MCA_VALSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELQTD';
    FieldName     := 'TOT_SELQTD';
    DataSet       := cdsConsulta;
    Expression    := 'SUM(MCA_QTDSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  cdsConsulta.AggregatesActive := True;
end;

procedure TfrmEstornaCartoes.pAcaoAdd;
begin
  inherited;
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('MCA_MARDES').AsString := 'M';
  cdsConsulta.FieldByName('MCA_QTDSEL').Value    := 1;
  cdsConsulta.FieldByName('MCA_VALSEL').Value    := cdsConsulta.FieldByName('MCA_VALTOT').Value;
  cdsConsulta.Post;

  If Not blnMarTod Then
    pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.pAcaoDel;
begin
  inherited;
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('MCA_MARDES').AsString := 'D';
  cdsConsulta.FieldByName('MCA_QTDSEL').Value    := 0;
  cdsConsulta.FieldByName('MCA_VALSEL').Value    := 0;
  cdsConsulta.Post;
  If Not blnMarTod Then
    pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.pAddListaQuery;
begin
  //ANTES DE MARCAR VERIFICAR SE ESTÁ CONCILIADO.
  if EstaConciliado(cdsConsulta.FieldByName('MCA_DOCBAN').AsString, 'MOVCAR') then
  begin
    fMensagem('', 'Não é possível estornar esse cartão, pois o mesmo está conciliado. ' +
                  'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
    Exit;
  end;
  inherited;
end;

Function TfrmEstornaCartoes.fEstorna: Boolean;
Begin

  Try

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fEstornaCartoes;
    frmGravando.lblGravando.Caption := 'Aguarde... Estornando Cartões';
    frmGravando.ShowModal;
    dbgConsulta.BorderStyle := bsNone;
    dbgConsulta.BorderStyle := bsSingle;
    ShowScrollBar(dbgConsulta.Handle, SB_VERT, true);

    pFreeAndNil(frmGravando);

    Result := blnBaixad;

  Except
    On E: Exception Do
    Begin
      blnBaixad := False;
			Raise Exception.Create(E.Message);
    End;
  End;
End;

procedure TfrmEstornaCartoes.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco := FALSE;

  if not fEmptyStr(FEmpresaCadastroMovimento) then
    edtCodEmp.Text := FEmpresaCadastroMovimento
  else
    edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;
  blnAcesso := fVerificaAcessoSistema('CARBAITODOS');

  qryGenCar := fCriaQuery(Self);
  qryGenCar := qryCadCar;

  pCarregaQuerys;
  pSetFocus(edtCodCar);
  pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.AtualizaCampoConcilMercadoLivre(
  ARegistros: TDataset);
  Var
    LUpdate: TUniQuery;
begin
  Try
    LUpdate := fCriaQuery;

    LUpdate.SQL.Text := 'UPDATE MER_MLPGTO SET MER_CONCIL=0 WHERE ' +
                        ' MER_SHP_ID="' + ARegistros.FieldByName('MCA_NUMNSU').AsString + '" ' +
                        ' AND MER_CONCIL=1';

    LUpdate.ExecSQL;

    If LUpdate.RowsAffected = 0 Then
    Begin
      fExecutaSQL('UPDATE MER_MLPGTO SET MER_CONCIL=0 WHERE ' +
                  ' MER_CODAUT="' + ARegistros.FieldByName('MCA_NUMCCD').AsString + '" ' +
                  ' AND MER_CONCIL=1');
    End;
  Finally
    FreeAndNil(LUpdate);
  End;

end;

procedure TfrmEstornaCartoes.btnCarrTitulosClick(Sender: TObject);
begin
  inherited;
 If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pExecutaConsulta, 'Aguarde... Filtrando registros.', '');

  cxgConsultaTableView.DataController.Filter.Clear;
  stlListSelecao.Clear;

  If cdsConsulta.RecordCount > 0 Then
  begin
    cdsConsulta.First;
    pSetFocus(cxgConsulta);
  end
  else
    pSetFocus(edtCodCar);
end;

procedure TfrmEstornaCartoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Or
     (stlListSelecao.Count <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cartão!', ['&Ok']);
    Exit;
  End;

  If fVerificaCampos And
     (fMensagem('', 'Confirma o estorno dos cartões selecionados?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnBaixad := False;
    Try

      Case fCfgSis('RDTEMB', varInteger) of
        1: blnDtaDoc := (fTipDtaEstBai(fVerificaAcessoSistema('DTAOEB')) = 2);
        2: blnDtaDoc := True;    // Data Documento;
        3: blnDtaDoc := False;   // Data Atual;
      Else
        blnDtaDoc := (fTipDtaEstBai(fVerificaAcessoSistema('DTAOEB')) = 2);
      End;

      //FECHAMENTO FINANCEIRO
      //VERIFICA A DATA DA BAIXA DO DOCUMENTO, CASO ESCOLHIDA
      if blnDtaDoc then
        if FechamentoFinanceiroJaRealizado then
          Exit;

      If CartoesJaEstornadoEmOutraEstacao Then
        Exit;

      If fEstorna Then
      Begin
        fCommit;
        stlListSelecao.Clear;
        fMensagem('', 'Cartões estornados com sucesso!', ['&Ok']);

        TfrmGravando.fExecutarModal(pExecutaConsulta, 'Aguarde... Filtrando registros.', '');
        pAtualizaTotalizadores;
      End

      Else fRollBack;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[TfrmEstornaCartoes.btnConfirmaClick]');
      End;
    End;
  End;
  dbgConsulta.Repaint;
  pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  blnMarTod := True;
  TfrmGravando.fExecutarModal(pDesmarcar, 'Aguarde... Desmarcando cartões.', '');
  pAtualizaTotalizadores;
  blnMarTod := False;
end;

function TfrmEstornaCartoes.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MOVCAR.AUTOINCREM AS AUTOINCREM,           ';
  strSQL := strSQL + '  MCA_NUMDUP AS NRODUP,                      ';
  strSQL := strSQL + '  MCA_PARCEL AS PARDUP,                      ';
  strSQL := strSQL + '  CONCAT(MCA_NUMDUP, MCA_PARCEL)             ';
  strSQL := strSQL + '                              AS MCA_NUMDUP, ';
  strSQL := strSQL + '  MCA_CODEMP,                                ';
  strSQL := strSQL + '  MCA_DTAVEN,                                ';
  strSQL := strSQL + '  MCA_VALORI AS MCA_VALTOT,                  ';
  strSQL := strSQL + '  MCA_VALTAX,                                ';
  strSQL := strSQL + '  MCA_VALSTA,                                ';
  strSQL := strSQL + '  MCA_VALORI,                                ';
  strSQL := strSQL + '  MCA_VALDUP,                                ';
  strSQL := strSQL + '  MCA_PERCAR,                                ';
  strSQL := strSQL + '  MCA_CODCLI,                                ';
  strSQL := strSQL + '  CLI_NOMCLI,                                ';
  strSQL := strSQL + '  CAR_DESCAR,                                ';
  strSQL := strSQL + '  CAR_CODEMP,                                ';
  strSQL := strSQL + '  CAR_MKTPLA,                                ';
  strSQL := strSQL + '  MCA_HIST01,                                ';
  strSQL := strSQL + '  MCA_HIST02,                                ';
  strSQL := strSQL + '  MCA_DTACAD,                                ';
  strSQL := strSQL + '  MCA_DTAREC,                                ';
  strSQL := strSQL + '  MCA_NUMCCD,                                ';
  strSQL := strSQL + '  MCA_PORBAI,                                ';
  strSQL := strSQL + '  MCA_CTABAI,                                ';
  strSQL := strSQL + '  MCA_CTABTX,                                ';
  strSQL := strSQL + '  MCA_PORBTX,                                ';
  strSQL := strSQL + '  MCA_NUMPOK,                                ';
  strSQL := strSQL + '  MCA_FORBTX,                                ';
  strSQL := strSQL + '  MCA_CTADEB,                                ';
  strSQL := strSQL + '  MCA_PORDEB,                                ';
  strSQL := strSQL + '  MCA_VALANT,                                ';
  strSQL := strSQL + '  MCA_TAXANT,                                ';
  strSQL := strSQL + '  MCA_DTACUP,                                ';
  strSQL := strSQL + '  MCA_EVECRE,                                ';
  strSQL := strSQL + '  MCA_EVETAX,                                ';
  strSQL := strSQL + '  MCA_EVEDEB,                                ';
  strSQL := strSQL + '  MCA_CTAANT,                                ';
  strSQL := strSQL + '  IFNULL(P.CON_CTAFRE, CAR_CTAFRE) AS CAR_CTAFRE, ';
  strSQL := strSQL + '  IFNULL(P.CON_CTAAJU, CAR_CTAAJU) AS CAR_CTAAJU, ';
  strSQL := strSQL + '  IFNULL(P.CON_CTACUP, CAR_CTACUP) AS CAR_CTACUP, ';
  strSQL := strSQL + '  MCA_DOCANT,                                ';
  strSQL := strSQL + '  MCA_ANTTAX,                                ';
  strSQL := strSQL + '  MCA_FREMKT,                                ';
  strSQL := strSQL + '  MCA_VALAJU,                                ';
  strSQL := strSQL + '  MCA_CUPMKT,                                ';
  strSQL := strSQL + '  MCA_DOCFRE,                                ';
  strSQL := strSQL + '  MCA_DOCAJU,                                ';
  strSQL := strSQL + '  MCA_DOCCUP,                                ';
  strSQL := strSQL + '  "D" AS MCA_MARDES,                         ';
  strSQL := strSQL + '  0.00 AS MCA_VALSEL,                        ';
  strSQL := strSQL + '  0 AS MCA_QTDSEL,                           ';
  strSQL := strSQL + '  SUBSTRING(MCA_DOCUME,1,IF(LOCATE("AG", MCA_DOCUME), LOCATE("AG", MCA_DOCUME) + 5, 21)) AS MCA_DOCUME, ';
  strSQL := strSQL + '  MCA_CODCAR,                                ';
  strSQL := strSQL + '  MCA_NUMNSU,                                ';
  strSQL := strSQL + '  MCA_VALREC,                                ';
  strSQL := strSQL + '  MCA_CHACON,                                ';
  strSQL := strSQL + '  MCA_DTABAI,                                ';
  strSQL := strSQL + '  CTB_CODEMP AS MCA_EMPBAI,                  ';
  strSQL := strSQL + ' "N" AS MCA_AJUSTE,                          ';
  strSQL := strSQL + '  MCA_DOCBAN,                                ';
  strSQL := strSQL + '  MCA_DOCBTX,                                ';
  strSQL := strSQL + '  MCA_DOCDEB                                 ';
  strSQL := strSQL + 'FROM                                         ';
  strSQL := strSQL + '  MOVCAR                                     ';
  strSQL := strSQL + 'INNER JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  strSQL := strSQL + 'INNER JOIN CADCLI ON MCA_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'LEFT  JOIN MOVBAN ON MCA_DOCBAN = CTB_SEQLAN ';
  strSQL := strSQL + 'LEFT  JOIN CONPOR P ON P.CON_CODCAR = CAR_CODCAR ';
  strSQL := strSQL + '                   AND P.CON_CODEMP = MCA_CODEMP ';
  strSQL := strSQL + 'WHERE                                        ';
  strSQL := strSQL + '  MCA_DTAREC IS NOT NULL                     ';

  If Not fEmptyStr(edtCodCar.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCar, arrCartao, 'MCA_CODCAR', 'CODCAR')
  Else
  Begin
    If Not blnAcesso Then
      strSQL := strSQL + ' AND ((CAR_CODEMP IS NULL) OR (CAR_CODEMP IN("",' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + '))) ';
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin

    Case edtTipoData.Text[1] Of
      'V': strSQL := strSQL + '  AND MCA_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
      'C': strSQL := strSQL + '  AND MCA_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
      'B': strSQL := strSQL + '  AND MCA_DTABAI BETWEEN :DTAINI AND :DTAFIN ';
      'R': strSQL := strSQL + '  AND MCA_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
    End;

  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'MCA_CODEMP', 'CODEMP')
  Else If Not blnAcesso Then
    strSQL := strSQL + '  AND ((MCA_CODEMP IS NULL) OR (MCA_CODEMP IN("",' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + '))) ';

  If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(MCA_PORBAI, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(MCA_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(MCA_PORBTX, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(MCA_PORBTX, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(MCA_PORDEB, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(MCA_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  Result := strSQL;
End;

function TfrmEstornaCartoes.fInLista(strValor: String): Boolean;
begin
  If blnQuoteLista Then
    Result := (stlListselecao.IndexOf('''' + strValor + '''') > -1) Or
              (stlListselecao.IndexOf(strValor) > -1)
  Else
    Result := stlListselecao.IndexOf(strValor) > -1;
end;

function TfrmEstornaCartoes.fSetParametros: Boolean;
  Var
    strEmp,
    strCartao: String;
Begin
  Result := TRUE;
  With qryConsulta Do
  Begin

    If Not fEmptyStr(edtCodCar.Text) Then
      pSetaParam(edtCodCar.Text, arrCartao, strCartao, 'CODCAR', qryConsulta);

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryConsulta);

  End;
End;

procedure TfrmEstornaCartoes.btnMarcarClick(Sender: TObject);
begin
  inherited;
  blnMarTod := True;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando cartões';
  frmGravando.ShowModal;
  blnMarTod := False;
end;

function TfrmEstornaCartoes.fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
var
  LRecNo: Integer;
begin
  Result := True;
  If (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) Then
  Begin
    stlListSelecao.Clear;
    With cdsConsulta Do
    Begin
      cxgConsultaTableView.BeginUpdate;
      DisableControls;
      LRecNo := RecNo;
      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);
        pAddListaQuery;
        Next;
      End;
      RecNo := LRecNo;
      cxgConsultaTableView.EndUpdate;
      EnableControls;
    End;

    pAtualizaTotalizadores;
  End
  else
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cartão!', ['&OK']);
  end;
end;

Procedure TfrmEstornaCartoes.pDesmarcar;
var
  LRecNo: Integer;
Begin
  If (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) Then
  begin
    stlListSelecao.Clear;

    With cdsConsulta Do
    Begin

      cxgConsultaTableView.BeginUpdate;
      DisableControls;
      LRecNo := RecNo;
      First;

      While Not Eof Do
      Begin
        pAcaoDel;
        Next;
      End;

      RecNo := LRecNo;
      cxgConsultaTableView.EndUpdate;
      EnableControls;
    End;

    pAtualizaTotalizadores;
//    dbgConsulta.Refresh;
  end;
End;

procedure TfrmEstornaCartoes.btnMudaOrdemClick(Sender: TObject);
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cartão!', ['&Ok']);
  End
  else
    inherited;
end;

procedure TfrmEstornaCartoes.btnPesquisarClick(Sender: TObject);
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cartão!', ['&Ok']);
  End
  else
    inherited;
end;

function TfrmEstornaCartoes.CartoesJaEstornadoEmOutraEstacao: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If cdsConsulta.IsEmpty Then
    Exit(False);

  If stlListSelecao.Count = 0 Then
    Exit(False);

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT MCA_NUMCCD, ' +
                          '       MCA_NUMNSU, ' +
                          '       MCA_CODEMP, ' +
                          '       MCA_CODCAR, ' +
                          '       MCA_CODCLI  ' +
                          'FROM MOVCAR ' +
                          'WHERE AUTOINCREM IN (' + stlListSelecao.CommaText + ') ' +
                          '  AND MCA_DTAREC IS NULL ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
    If Result Then
      fMensagem('ATENÇÃO', 'O cartão com a Liberação: ' + LConsulta.FieldByName('MCA_NUMCCD').AsString + ', ' +
                           'Número NSU: ' + LConsulta.FieldByName('MCA_NUMNSU').AsString + ' e ' +
                           'Código da Empresa: ' + LConsulta.FieldByName('MCA_CODEMP').AsString + ' ' +
                           'já foi estonado em outra estação.' + #13 +
                           'Recarregue os dados para atualizar os registros.', ['&Ok']);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmEstornaCartoes.cxgConsultaTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAddListaQuery;
  pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.cxgConsultaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (blnTemSelecao Or (Assigned(stlListSelecao) And (stlListSelecao.Count > 0))) And
     fInLista(VarToStr(AViewInfo.GridRecord.Values[cxgConsultaTableViewAUTOINCREM.Index])) Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmEstornaCartoes.cxgConsultaTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pAddListaQuery;
    pAtualizaTotalizadores;
  End;
end;

procedure TfrmEstornaCartoes.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If cdsConsulta.Active Then
  Begin
    If Key = VK_Return Then
    begin
      pAtualizaTotalizadores;
    end;
  End;
end;

procedure TfrmEstornaCartoes.dtsConsultaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  pAtualizaTotalizadores;
end;

procedure TfrmEstornaCartoes.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, False, False, False, True, True, Not blnAcesso) Then
  Begin
    If (fValidaCampos(Self, True)) Then
      Self.SelectNext(ActiveControl, True, True);
    pCarregaCartao;
  End;
end;

procedure TfrmEstornaCartoes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, Not blnAcesso) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEstornaCartoes.FechamentoFinanceiroJaRealizado: Boolean;
  Var
    LEmpresaFechamento: String;
    LRecNo: Integer;
begin
  LRecNo:= 0;
  Result := False;

  Try
    LRecNo := cdsConsulta.RecNo;
    cdsConsulta.DisableControls;
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := 'MCA_MARDES=''M''';
    cdsConsulta.Filtered := True;
    cdsConsulta.First;

    While Not cdsConsulta.Eof Do
    Begin
      LEmpresaFechamento := IIF(cdsConsulta.FieldByName('MCA_EMPBAI').IsNull,
                                                                VS_strCodEmp,
                              cdsConsulta.FieldByName('MCA_EMPBAI').AsString);

      If objFechamento.FechamentoFinanceiroJaRealizado(LEmpresaFechamento, cdsConsulta.FieldByName('MCA_DTAREC').AsDateTime) Then
        Exit(True);

      cdsConsulta.Next;
    End;

  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.RecNo := LRecNo;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmEstornaCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCar);
end;

procedure TfrmEstornaCartoes.FormCreate(Sender: TObject);
begin
  qryCadCar := fCriaQuery(Self);
  qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  inherited;
  pCriaAggrFields;
  blnBaixad := False;
  blnMarTod := False;
  pnlTail.Visible := True;

  {***********************************************************************}
  {* MELHORA O DESEMPENHO AO MARCAR TODOS E NAVEGAR NO GRID (OnDrawCell) *}
  {********************************************************************RP*}
  stlListSelecao.Sorted := True;
end;

procedure TfrmEstornaCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(qryEstCar) Then
    FreeAndNil(qryEstCar);
end;

procedure TfrmEstornaCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: if dbgConsulta.Focused then
               Begin
                 cdsConsulta.Close;
                 pSetFocus(edtCodCar);
                 pAtualizaTotalizadores;
               End

               Else inherited;

    VK_F10   : btnConfirma.Click;
    VK_F7    : btnMarcar.Click;
    VK_F8    : btnDesmarcar.Click;
    VK_F3    : btnMudaOrdem.Click;
    VK_F5    : btnPesquisar.Click;

    VK_Return: Begin
                 If (stlListSelecao.Count > 0) And
                    (pnlPesquisa.Visible)      And
                    ((edtData.Focused)         Or
                     (edtNumero.Focused)       Or
                     (edtValor.Focused)        Or
                     (edtString.Focused))      Then
                 Begin
                   fMensagem('', 'Para processar o filtro informado o sistema irá desmarcar os registros marcados anteriormente!', ['&Ok']);
                   btnMarcar.Click;
                   inherited;
                 End
                 Else inherited;

               End

    Else inherited;

  End;
end;

end.
