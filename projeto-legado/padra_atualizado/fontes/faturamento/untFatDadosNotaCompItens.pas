unit untFatDadosNotaCompItens;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, untFuncFat, strUtils,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts, Uni,untDigDescComplemento,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, DB, Windows, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  Datasnap.DBClient, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit;

type
  TfrmFatDadosNotaCompItens = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGridCitel;
    dtsItensNfe: TDataSource;
    cxgItensView: TcxGridDBBandedTableView;
    cdsItensNFe: TUniClientDataSet;
    cdsItensNFeAutoincremento: TStringField;
    cdsItensNFeCodigo: TStringField;
    cdsItensNFeDescricao: TStringField;
    cdsItensNFeCfop: TStringField;
    cdsItensNFeCst: TStringField;
    cdsItensNFeUnidade: TStringField;
    cdsItensNFeAlq_icms_ori: TFloatField;
    cdsItensNFeBase_icms_ori: TFloatField;
    cdsItensNFeValor_icms_ori: TFloatField;
    cdsItensNFeBase_icms_st_ori: TFloatField;
    cdsItensNFeValor_icms_st_ori: TFloatField;
    cdsItensNFeBase_ipi_ori: TFloatField;
    cdsItensNFeAlq_ipi_ori: TFloatField;
    cdsItensNFeValor_ipi_ori: TFloatField;
    cdsItensNFeAlq_icms: TFloatField;
    cdsItensNFeBase_icms: TFloatField;
    cdsItensNFeValor_icms: TFloatField;
    cdsItensNFeBase_icms_st: TFloatField;
    cdsItensNFeValor_icms_st: TFloatField;
    cdsItensNFeBase_ipi: TFloatField;
    cdsItensNFeAlq_ipi: TFloatField;
    cdsItensNFeValor_ipi: TFloatField;
    cxgItensViewcodigo: TcxGridDBBandedColumn;
    cxgItensViewdescricao: TcxGridDBBandedColumn;
    cxgItensViewcfop: TcxGridDBBandedColumn;
    cxgItensViewcst: TcxGridDBBandedColumn;
    cxgItensViewunidade: TcxGridDBBandedColumn;
    cxgItensViewbase_icms_ori: TcxGridDBBandedColumn;
    cxgItensViewalq_icms_ori: TcxGridDBBandedColumn;
    cxgItensViewvalor_icms_ori: TcxGridDBBandedColumn;
    cxgItensViewbase_icms_st_ori: TcxGridDBBandedColumn;
    cxgItensViewvalor_icms_st_ori: TcxGridDBBandedColumn;
    cxgItensViewbase_ipi_ori: TcxGridDBBandedColumn;
    cxgItensViewalq_ipi_ori: TcxGridDBBandedColumn;
    cxgItensViewvalor_ipi_ori: TcxGridDBBandedColumn;
    cxgItensViewbase_icms: TcxGridDBBandedColumn;
    cxgItensViewalq_icms: TcxGridDBBandedColumn;
    cxgItensViewvalor_icms: TcxGridDBBandedColumn;
    cxgItensViewbase_icms_st: TcxGridDBBandedColumn;
    cxgItensViewvalor_icms_st: TcxGridDBBandedColumn;
    cxgItensViewbase_ipi: TcxGridDBBandedColumn;
    cxgItensViewalq_ipi: TcxGridDBBandedColumn;
    cxgItensViewvalor_ipi: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsBands: TcxStyle;
    cxsIcms: TcxStyle;
    cxsIPI: TcxStyle;
    cxsRetido: TcxStyle;
    cdsItensNFeDocumento: TStringField;
    cxgItensViewdocumento: TcxGridDBBandedColumn;
    cxsGroupHeader: TcxStyle;
    cdsItensNFeCst_ori: TStringField;
    cdsItensNFebase_fcp_st: TFloatField;
    cdsItensNFealq_fcp_st: TFloatField;
    cdsItensNFevalor_fcp_st: TFloatField;
    cxgItensViewbase_fcp_st: TcxGridDBBandedColumn;
    cxgItensViewalq_fcp_st: TcxGridDBBandedColumn;
    cxgItensViewvalor_fcp_st: TcxGridDBBandedColumn;
    cdsItensNFebase_fcp_icms: TFloatField;
    cdsItensNFealq_fcp_icms: TFloatField;
    cdsItensNFevalor_fcp_icms: TFloatField;
    cxgItensViewbase_fcp_icms: TcxGridDBBandedColumn;
    cxgItensViewalq_fcp_icms: TcxGridDBBandedColumn;
    cxgItensViewvalor_fcp_icms: TcxGridDBBandedColumn;
    cxgItensViewBase_Difal: TcxGridDBBandedColumn;
    cxgItensViewValor_Difal: TcxGridDBBandedColumn;
    cdsItensNFebase_difal: TFloatField;
    cdsItensNFevalor_difal: TFloatField;
    cdsItensNFecst_pis: TStringField;
    cdsItensNFecst_cofins: TStringField;
    cdsItensNFebase_pis: TFloatField;
    cdsItensNFebase_cofins: TFloatField;
    cdsItensNFealiquota_pis: TFloatField;
    cdsItensNFealiquota_cofins: TFloatField;
    cdsItensNFevalor_pis: TFloatField;
    cdsItensNFevalor_cofins: TFloatField;
    cxgItensViewcst_pis: TcxGridDBBandedColumn;
    cxgItensViewbase_pis: TcxGridDBBandedColumn;
    cxgItensViewaliquota_pis: TcxGridDBBandedColumn;
    cxgItensViewvalor_pis: TcxGridDBBandedColumn;
    cxgItensViewcst_cofins: TcxGridDBBandedColumn;
    cxgItensViewbase_cofins: TcxGridDBBandedColumn;
    cxgItensViewaliquota_cofins: TcxGridDBBandedColumn;
    cxgItensViewvalor_cofins: TcxGridDBBandedColumn;
    cdsItensNFeIcmsOp: TFloatField;
    cdsItensNFePerDif: TFloatField;
    cdsItensNFeIcmDif: TFloatField;
    cxgItensViewPerDif: TcxGridDBBandedColumn;
    cxgItensViewIcmDif: TcxGridDBBandedColumn;
    cxgItensViewColumn1: TcxGridDBBandedColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure cdsItensNFeBeforePost(DataSet: TDataSet);
    procedure cxgItensViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensViewcst_cofinsPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensViewcst_pisPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cdsItensNFealiquota_cofinsChange(Sender: TField);
    procedure cdsItensNFealiquota_pisChange(Sender: TField);
    procedure cdsItensNFePerDifChange(Sender: TField);
  private
    { Private declarations }
    blnValidar: Boolean;
    procedure pCarregarItens;
    procedure pSalvarImpostosDigitados;
    function fValidaImpostosDigitados: Boolean;
    function fMesmoGrupoSitTrib(strSitAnt, strCodSit: String): Boolean;
    function fValidouPreenchimentoCSTPisCofins(const strCST : String) : Boolean;
    function fValidouCSTPisCofinsTributado(const strCST : String; const fltBase, fltValor, fltAliquota : Double) : Boolean;
    procedure pCalculaValor(DataSet: TDataSet; fldBase, fldAlq, fldValor: TField);
    procedure pCalculaComplementoIcmsComDiferimento;
    procedure pCalculaFCPComReducaoBaseIcmsST;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    blnComplementoDifalFcp: Boolean;
  end;


implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFuncFatTypes,
  untConstantes, untFuncoesConsulta, untNotCom, Shared.Functions.Types;

{$R *.dfm}

procedure TfrmFatDadosNotaCompItens.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Deseja realmente cancelar a operação?') Then
    Close;
end;

procedure TfrmFatDadosNotaCompItens.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fValidaImpostosDigitados Then
  Begin
    pSalvarImpostosDigitados;

    If ( fatVenda.objNfeComplemento.TotalItens.fltValorIcms +
         fatVenda.objNfeComplemento.TotalItens.fltValorST   +
         fatVenda.objNfeComplemento.TotalItens.fltValFcpST  +
         fatVenda.objNfeComplemento.TotalItens.fltValorIPI  +
         fatVenda.objNfeComplemento.TotalItens.recDifalFCP.fltValFcp +
         fatVenda.objNfeComplemento.TotalItens.recDifalFCP.fltDifDes) <= 0.00 Then
    Begin
      If fPergunta('Não foi informado valor de ICMS, ST, FCP ST, IPI ou DIFAL nos produtos. '+
                   'Deseja continuar e descartar a emissão de nota de '+
                   'complemento/crédito por produto?') Then
      Begin
        fatVenda.objNfeComplemento.pRemoverItens;
        Close;
      End;
    End
    Else
      Close;

  End;
end;

function TfrmFatDadosNotaCompItens.fValidouCSTPisCofinsTributado(const strCST : String; const fltBase, fltValor, fltAliquota : Double) : Boolean;
  Var
    blnTemValorZero : Boolean;
begin
  Result := True;

  blnTemValorZero := (fFormataFloat(fltBase, 2) = 0) Or (fFormataFloat(fltValor, 2) = 0) Or (fFormataFloat(fltAliquota, 2) = 0);

  If (strCST = '01') And (blnTemValorZero) Then
    Exit(False);

  If (strCST = '02') And (blnTemValorZero) Then
    Exit(False);
end;

Function TfrmFatDadosNotaCompItens.fMesmoGrupoSitTrib(strSitAnt, strCodSit: String): Boolean;
Begin
  If Pos(strSitAnt, CST_SUBSTITUICAO) > 0 Then
  Begin
    Result := (Pos(strCodSit, CST_SUBSTITUICAO) > 0) Or (Pos(strCodSit, CST_ANTECIPACAO_ICMS) > 0);
    If Not Result Then
      fMensagem('Alteração não permitida!','A CST de origem deste produto é ST. Neste caso, só é permitido informar CST''s de Substituição ou CST''s x90 (Outros).'+#13
                                          +'Verifique seu cadastro de Abreviação de ICMS.', ['&Ok']);
  End
  Else
  Begin
    Result := (Pos(strCodSit, CST_SUBSTITUICAO) <= 0);
    If Not Result Then
      fMensagem('Alteração não permitida!','Não é permitido informar CST de Substituição para produtos que possuem outra origem tributária.'+#13
                                          +'Verifique seu cadastro de Abreviação de ICMS.', ['&Ok']);
  End
End;

procedure TfrmFatDadosNotaCompItens.cdsItensNFealiquota_cofinsChange(
  Sender: TField);
begin
  inherited;
  pCalculaValor(cdsItensNFe, cdsItensNFebase_cofins, cdsItensNFealiquota_cofins, cdsItensNFevalor_cofins);
end;

procedure TfrmFatDadosNotaCompItens.cdsItensNFealiquota_pisChange(
  Sender: TField);
begin
  inherited;
  pCalculaValor(cdsItensNFe, cdsItensNFebase_pis, cdsItensNFealiquota_pis, cdsItensNFevalor_pis);
end;

procedure TfrmFatDadosNotaCompItens.pCalculaValor(DataSet: TDataSet; fldBase, fldAlq, fldValor: TField);
begin
  If DataSet.State = dsEdit Then
  Begin
    fldValor.AsFloat := fFormataFloat(fldBase.AsFloat * fldAlq.AsFloat / 100, 2);
  End;
end;

procedure TfrmFatDadosNotaCompItens.pCalculaComplementoIcmsComDiferimento;
var
  fltBasIcm: Double;
  fltPerIcm: Double;
  fltIcmsOp: Double;
  fltValIcm: Double;
  fltBasDif: Double;
  fltPerDif: Double;
  fltIcmDif: Double;

begin
  If (cdsItensNFePerDif.AsFloat > 0) Then
  Begin
    fltBasIcm := cdsItensNFeBase_icms.AsFloat;
    fltPerIcm := cdsItensNFeAlq_icms.AsFloat;
    fltPerDif := cdsItensNFePerDif.AsFloat;

    fltIcmsOp := fFormataFloat(fltBasIcm * (fltPerIcm / 100), 2);
    fltBasDif := fFormataFloat(fltBasIcm * (fltPerDif / 100), 2);
    fltBasDif := fFormataFloat(fltBasIcm - fltBasDif, 2);
    fltValIcm := fFormataFloat(fltBasDif * (fltPerIcm / 100), 2);
    fltIcmDif := fFormataFloat(fltIcmsOp - fltValIcm, 2);

    cdsItensNFeIcmsOp.AsFloat     := fltIcmsOp;
    cdsItensNFeIcmDif.AsFloat     := fltIcmDif;
    cdsItensNFeValor_icms.AsFloat := fltValIcm;

    If not (RightStr(cdsItensNFeCst.AsString, 2) = '51') Then
      cdsItensNFeCst.AsString := LeftStr(cdsItensNFeCst.AsString, 1) + '51';
  End;
end;

procedure TfrmFatDadosNotaCompItens.pCalculaFCPComReducaoBaseIcmsST;
Var
  LValFCP: Double;
  LValFCP_ST: Double;
begin
  If not fatVenda.fNotaDeComplementoCalculaFCPComReducaoBaseIcmsST Then
    Exit;

  If not (RightStr(cdsItensNFeCst.AsString, 2) = '10') Then
    Exit;

  LValFCP    := fFormataFloat((cdsItensNFeBase_Fcp_Icms.AsFloat * cdsItensNFeAlq_Fcp_Icms.AsFloat) / 100, 2);
  LValFCP_ST := fFormataFloat((cdsItensNFeBase_Fcp_St.AsFloat   * cdsItensNFeAlq_Fcp_St.AsFloat)   / 100, 2);
  LValFCP_ST := fFormataFloat(LValFCP_ST - LValFCP, 2);

  cdsItensNFeValor_Fcp_St.AsFloat   := 0;
  cdsItensNFevalor_Fcp_Icms.AsFloat := 0;

  If (LValFCP > 0) Then
    cdsItensNFevalor_Fcp_Icms.AsFloat := LValFCP;

  If (LValFCP_ST > 0) Then
    cdsItensNFeValor_Fcp_St.AsFloat := LValFCP_ST;
end;

procedure TfrmFatDadosNotaCompItens.cdsItensNFePerDifChange(Sender: TField);
begin
  inherited;
  pCalculaComplementoIcmsComDiferimento;
end;

procedure TfrmFatDadosNotaCompItens.cdsItensNFeBeforePost(DataSet: TDataSet);

  function fValidaValor(fldValor: TField): Boolean;
  begin
    Result := fldValor.AsFloat >= 0;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo ' + fldValor.DisplayLabel +
                ' deve ser maior ou igual à zero!', ['&Ok']);
    End;
  end;

  function fValidaBaseValor(fldBase, fldValor: TField): Boolean;
  begin
    Result := True;

    If (fldBase.AsFloat = 0) And (fldValor.AsFloat > 0) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Campo ' + fldBase.DisplayLabel +
                ' deve ser informado!', ['&Ok']);
    End;

  end;

  function fValidaValorRetido(fldST: TField): Boolean;
  begin
    Result := True;

    If (fldST.Value <> fldST.OldValue) And
       (Pos(cdsItensNFeCst.AsString, CST_SUBSTITUICAO) <= 0) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Campo ' + fldST.DisplayLabel +
                ' não pode ser informado, pois este produto' +
                ' não é ST!', ['&Ok']);
    End;

  End;

  function fVerificaBaseValor: Boolean;
  begin
    Result := False;

    If not fValidaBaseValor(cdsItensNFeBase_icms, cdsItensNFeValor_icms) Then
      Exit;

    If not fValidaBaseValor(cdsItensNFeBase_ipi, cdsItensNFeValor_ipi) Then
      Exit;

    If not fValidaBaseValor(cdsItensNFeBase_fcp_st, cdsItensNFeValor_fcp_st) Then
      Exit;

    If not fValidaBaseValor(cdsItensNFeBase_icms_st, cdsItensNFeValor_icms_st) Then
      Exit;

    If not fValidaBaseValor(cdsItensNFebase_fcp_icms, cdsItensNFevalor_fcp_icms) Then
      Exit;

    If blnComplementoDifalFcp Then
      Exit(True);

    If not fValidaBaseValor(cdsItensNFeBase_icms, cdsItensNFebase_fcp_icms) Then
      Exit;

    Result := True;
  end;

begin
  inherited;

  If not blnComplementoDifalFcp Then
  Begin
    If (cdsItensNFeBase_icms.AsFloat <= 0) Then
    Begin
      If (Pos(cdsItensNFeCst.AsString, CST_TRIBUTADO) > 0) Then
        cdsItensNFeCst.AsString := AnsiLeftStr(cdsItensNFeCst.AsString, 1) +
                                   IIF(fatVenda.strCliOrg <> 'S', '41', '40');
    End
    Else If (AnsiRightStr(cdsItensNFeCst.AsString, 2) = IIF(fatVenda.strCliOrg <> 'S', '41', '40')) Then
      cdsItensNFeCst.AsString := cdsItensNFeCst_Ori.AsString;
  End;

  {*******************************************}
  {* CASO O CST SEJA X60 E POSSUA IPI OU ST  *}
  {* ALTERA O MESMO PARA X10, EX: 060 -> 010 *}
  {***************************************JC**}
  If (Pos(cdsItensNFeCst.AsString, '060_160_260_') > 0) And
     ((cdsItensNFeBase_ipi.AsFloat + cdsItensNFeBase_icms_st.AsFloat) > 0) Then
  Begin
    cdsItensNFeCst.AsString := LeftStr(cdsItensNFeCst.AsString, 1) + '10';
  End;

  If Not blnValidar Then
    Exit;

  cdsItensNFeCst.AsString := fStrZero(cdsItensNFeCst.AsString, 3);

  If fEmptyStr(fRetSitTributaria(cdsItensNFeCst.AsString)) Then
  Begin
    pMensagemOk('Situação Tributária não encontrada!');
    DataSet.Cancel;
    Abort;
  End;

  If Not fMesmoGrupoSitTrib(cdsItensNFeCst_ori.AsString, cdsItensNFeCst.AsString) then
  Begin
    pMensagemOk('Situação tributária não permitida!');
    DataSet.Cancel;
    Abort;
  End;

  pCalculaValor(DataSet, cdsItensNFeBase_icms, cdsItensNFeAlq_icms, cdsItensNFeValor_icms);
  pCalculaValor(DataSet, cdsItensNFeBase_ipi , cdsItensNFeAlq_ipi , cdsItensNFeValor_ipi );

  If Not (fValidaValor(cdsItensNFeBase_icms)      And
          fValidaValor(cdsItensNFeAlq_icms)       And
          fValidaValor(cdsItensNFeValor_icms)     And
          fValidaValor(cdsItensNFeBase_ipi)       And
          fValidaValor(cdsItensNFeAlq_ipi)        And
          fValidaValor(cdsItensNFeValor_ipi)      And
          fValidaValor(cdsItensNFebase_fcp_st)    And
          fValidaValor(cdsItensNFealq_fcp_st)     And
          fValidaValor(cdsItensNFevalor_fcp_st)   And
          fValidaValor(cdsItensNFeBase_icms_st)   And
          fValidaValor(cdsItensNFeValor_icms_st)  And
          fValidaValor(cdsItensNFebase_fcp_icms)  And
          fValidaValor(cdsItensNFealq_fcp_icms)   And
          fValidaValor(cdsItensNFevalor_fcp_icms) And
          fValidaValor(cdsItensNFevalor_difal))Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not fVerificaBaseValor Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  If Not (fValidaValorRetido(cdsItensNFeBase_icms_st )  And
          fValidaValorRetido(cdsItensNFeValor_icms_st)) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;

  pCalculaComplementoIcmsComDiferimento;
  pCalculaFCPComReducaoBaseIcmsST;

end;

procedure TfrmFatDadosNotaCompItens.cxgItensViewcst_cofinsPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If (StrToIntDef(DisplayValue, -1) = -1) Or
     (Not fValidouPreenchimentoCSTPisCofins(DisplayValue)) Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('CST de COFINS preenchido incorretamente!');
  End;
end;

procedure TfrmFatDadosNotaCompItens.cxgItensViewcst_pisPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If (StrToIntDef(DisplayValue, -1) = -1) Or
     (Not fValidouPreenchimentoCSTPisCofins(DisplayValue)) Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('CST de PIS preenchido incorretamente!');
  End;
end;

procedure TfrmFatDadosNotaCompItens.cxgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  function GetFocusedColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      If cxgItensView.Columns[intIndex].Focused Then
      Begin
        Result := intIndex;
        Break;
      End;
  end;

  function GetLastFocusingColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      With cxgItensView.Columns[intIndex], Options Do
        If Visible And Focusing Then
          Result := intIndex;
  end;

  function GetFirstFocusingColumnIndex: Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To cxgItensView.ColumnCount - 1 Do
      With cxgItensView.Columns[intIndex], Options Do
        If Visible And Focusing Then
        Begin
          Result := intIndex;
          Break;
        End;
  end;

  procedure GoToNextCell;
    Var
      FocusIndex: Integer;
  begin
    FocusIndex := GetFocusedColumnIndex;

    If FocusIndex = GetLastFocusingColumnIndex Then
    Begin

      If cxgItensView.DataController.RecNo < cxgItensView.DataController.RecordCount Then
      Begin
        cxgItensView.DataController.GotoNext;
        cxgItensView.DataController.Edit;
        cxgItensView.Columns[GetFirstFocusingColumnIndex].Focused := True;
      End
      Else
        SelectNext(ActiveControl, True, True);

      Exit;
    End;

    Repeat
      Inc(FocusIndex);

      With cxgItensView.Columns[FocusIndex], Options Do
      Begin
        If Visible And Focusing Then
        Begin
          Focused := True;
          Break;
        End;
      End;

    Until FocusIndex = GetLastFocusingColumnIndex;

  end;

begin
  inherited;
  Case Key Of
    VK_ESCAPE : btnCancelaDados.Click;

    VK_F10    : Begin
                  btnConfirmaDados.Click;
                  Key := 0;
                End;

    VK_RETURN : If cxgitensview.Focused Then
                Begin
                  If (cdsItensNfe.State = dsEdit) Then
                    cdsItensNfe.Post;
                  GoToNextCell;
                End;
  End;
end;

procedure TfrmFatDadosNotaCompItens.cxgItensViewKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCadSit: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;

  If cxgItensViewCst.Focused And fEntraCons(Key) Then
  Begin
    qryCadSit := fCriaQuery(Self);

    If fPesqSitTributaria(Self,
                          Nil,
                          Nil,
                          qryCadSit,
                          Key,
                          arrSel) Then
    Begin
      If fMesmoGrupoSitTrib(cdsItensNFeCst_ori.AsString, qryCadSit.FieldByName('TRI_CODTRI').AsString) Then
      Begin
        If cdsItensNfe.State <> dsEdit Then
          cdsItensNfe.Edit;

        cdsItensNfeCst.AsString := qryCadSit.FieldByName('TRI_CODTRI').AsString;
        cdsItensNfe.Post;
      End;
    End;

    FreeAndNil(qryCadSit);
  End;
end;

procedure TfrmFatDadosNotaCompItens.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarItens;
end;

function TfrmFatDadosNotaCompItens.fValidaImpostosDigitados: Boolean;
begin

  Try
    cdsItensNFe.First;

    While Not cdsItensNFe.Eof Do
    Begin
      If cdsItensNFe.State = dsBrowse Then
        cdsItensNFe.Edit;

      cdsItensNFe.Post;

      If (Not fValidouPreenchimentoCSTPisCofins(cdsItensNFecst_pis.AsString)) Or
         (Not fValidouPreenchimentoCSTPisCofins(cdsItensNFecst_cofins.AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar dados válidos de PIS/COFINS em todos os itens!', ['&OK']);
        Result := False;
        Exit;
      End;

      If (Not fValidouCSTPisCofinsTributado(cdsItensNFecst_pis.AsString, cdsItensNFebase_pis.AsFloat, cdsItensNFevalor_pis.AsFloat, cdsItensNFealiquota_pis.AsFloat)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher valores para PIS Tributado!', ['&OK']);
        Result := False;
        Exit;
      End;

      If (Not fValidouCSTPisCofinsTributado(cdsItensNFecst_cofins.AsString, cdsItensNFebase_cofins.AsFloat, cdsItensNFevalor_cofins.AsFloat, cdsItensNFealiquota_cofins.AsFloat)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher valores para COFINS Tributado!', ['&OK']);
        Result := False;
        Exit;
      End;

      cdsItensNFe.Next;
    End;

    Result := True;

  Except
    On E: EAbort Do
    Begin
      Result := False;
      //Caso abortou a operacao nao deve exibir a mensagem de erro
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TfrmFatDadosNotaCompItens.fValidouPreenchimentoCSTPisCofins(
  const strCST: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(strCST)) Then
    Exit;

  If (Length(strCST) <> 2) Then
    Exit;

  If (fRetSomenteNumeros(strCST) <> strCST) Then
    Exit;

  Result := True;
end;

procedure TfrmFatDadosNotaCompItens.pCarregarItens;
  Var
    itemNFe: TNfeComplementoItem;
begin
  blnValidar := False;
  pSetaCodIte(cdsItensNFecodigo);
  cdsItensNFe.CreateDataset;

  For itemNFe In fatVenda.objNfeComplemento.arrItensNFe Do
  Begin
    cdsItensNFe.Append;

    cdsItensNFeDocumento.AsString         := fatVenda.objNfeComplemento.notaReferenciada.strNumDoc + '-' +
                                             fatVenda.objNfeComplemento.notaReferenciada.strEspDoc + '-' +
                                             fatVenda.objNfeComplemento.notaReferenciada.strCodEmp;

    cdsItensNFeAutoincremento.AsString    := itemNFe.strAutInc;
    cdsItensNFeCodigo.AsString            := itemNFe.strCodIte;
    cdsItensNFeDescricao.AsString         := itemNFe.strDesIte;
    cdsItensNFeCfop.AsString              := itemNFe.strClaFis;
    cdsItensNFeCst.AsString               := itemNFe.strCodFis;
    cdsItensNFeCst_Ori.AsString           := itemNFe.strCstOri;
    cdsItensNFeUnidade.AsString           := itemNFe.strSigUni;

    cdsItensNFeBase_icms_ori.AsFloat      := itemNFe.fltBasIcmOri;
    cdsItensNFeAlq_icms_ori.AsFloat       := itemNFe.fltAlqIcmOri;
    cdsItensNFeValor_icms_ori.AsFloat     := itemNFe.fltValIcmOri;
    cdsItensNFeBase_icms_st_ori.AsFloat   := itemNFe.fltBasRetOri;
    cdsItensNFeValor_icms_st_ori.AsFloat  := itemNFe.fltValRetOri;
    cdsItensNFeBase_ipi_ori.AsFloat       := itemNFe.fltBasIpiOri;
    cdsItensNFeAlq_ipi_ori.AsFloat        := itemNFe.fltAlqIpiOri;
    cdsItensNFeValor_ipi_ori.AsFloat      := itemNFe.fltValIpiOri;

    cdsItensNFeBase_icms.AsFloat          := itemNFe.fltBasIcm;
    cdsItensNFeAlq_icms.AsFloat           := itemNFe.fltAlqIcm;
    cdsItensNFeValor_icms.AsFloat         := itemNFe.fltValIcm;
    cdsItensNFeBase_icms_st.AsFloat       := itemNFe.fltBasRet;
    cdsItensNFeValor_icms_st.AsFloat      := itemNFe.fltValRet;
    cdsItensNFeBase_ipi.AsFloat           := itemNFe.fltBasIpi;
    cdsItensNFeAlq_ipi.AsFloat            := itemNFe.fltAlqIpi;
    cdsItensNFeValor_ipi.AsFloat          := itemNFe.fltValIpi;

    cdsItensNFeBase_fcp_st.AsFloat        := itemNFe.fltBasFcpST;
    cdsItensNFeAlq_fcp_st.AsFloat         := itemNFe.fltAlqFcpST;
    cdsItensNFeValor_fcp_st.AsFloat       := itemNFe.fltValFcpST;

    cdsItensNFebase_fcp_icms.AsFloat      := 0;
    cdsItensNFealq_fcp_icms.AsFloat       := 0;
    cdsItensNFevalor_fcp_icms.AsFloat     := 0;

    cdsItensNFebase_difal.AsFloat         := 0;
    cdsItensNFevalor_difal.AsFloat        := 0;

    cdsItensNFeIcmsOp.AsFloat := 0;
    cdsItensNFePerDif.AsFloat := 0;
    cdsItensNFeIcmDif.AsFloat := 0;

    cdsItensNFecst_pis.AsString := '07';
    cdsItensNFebase_pis.AsFloat := 0;
    cdsItensNFealiquota_pis.AsFloat := 0;
    cdsItensNFevalor_pis.AsFloat := 0;

    cdsItensNFecst_cofins.AsString := '07';
    cdsItensNFebase_cofins.AsFloat := 0;
    cdsItensNFealiquota_cofins.AsFloat := 0;
    cdsItensNFevalor_cofins.AsFloat := 0;

    cdsItensNFe.Post;
  End;

  pSetFocus(cxgItens);
  cxgItensView.DataController.GoToFirst;//Posiciona na primeira linha (Agrupamento documento)
  cxgItensView.DataController.GoToNext;//Posiciona na segunda linha (Primeiro registro)
  cxgItensViewCst.Focused := True;
  cxgItensView.DataController.Edit;

  blnValidar := True;
end;

procedure TfrmFatDadosNotaCompItens.pSalvarImpostosDigitados;
  Var
    intItem: Integer;
    itemNFe: TNfeComplementoItem;
begin
  For intItem := 0 To Length(fatVenda.objNfeComplemento.arrItensNFe) -1 Do
  Begin
    itemNfe := fatVenda.objNfeComplemento.arrItensNFe[intItem];

    If cdsItensNFe.Locate('autoincremento', itemNFe.strAutInc, []) Then
    Begin
      itemNFe.tncTipoItemNotaComplemento := tncComplementoICMS;

      itemNFe.strCodFis := cdsItensNFeCst.AsString;

      itemNFe.fltBasIcm := cdsItensNFeBase_icms.AsFloat;
      itemNFe.fltAlqIcm := cdsItensNFeAlq_icms.AsFloat;
      itemNFe.fltValIcm := cdsItensNFeValor_icms.AsFloat;

      itemNfe.fltIcmsOp := cdsItensNFeIcmsOp.AsFloat;
      itemNfe.fltPerDif := cdsItensNFePerDif.AsFloat;
      itemNfe.fltIcmDif := cdsItensNFeIcmDif.AsFloat;

      itemNFe.fltBasIpi := cdsItensNFeBase_ipi.AsFloat;
      itemNFe.fltAlqIpi := cdsItensNFeAlq_ipi.AsFloat;
      itemNFe.fltValIpi := cdsItensNFeValor_ipi.AsFloat;

      itemNFe.fltBasRet := cdsItensNFeBase_icms_st.AsFloat;
      itemNFe.fltValRet := cdsItensNFeValor_icms_st.AsFloat;
      itemNFe.fltAlqRet := 0.00;
      itemNFe.fltBasFcpST := cdsItensNFebase_fcp_st.AsFloat;
      itemNFe.fltAlqFcpST := cdsItensNFealq_fcp_st.AsFloat;
      itemNFe.fltValFcpST := cdsItensNFevalor_fcp_st.AsFloat;

      itemNFe.recDifalFCP.fltBasFcp := cdsItensNFebase_fcp_icms.AsFloat;
      itemNFe.recDifalFCP.fltPerFcp := cdsItensNFealq_fcp_icms.AsFloat;
      itemNFe.recDifalFCP.fltValFcp := cdsItensNFevalor_fcp_icms.AsFloat;

      itemNFe.recDifalFCP.fltBcuFde := cdsItensNFebase_difal.AsFloat;
      itemNFe.recDifalFCP.fltDifDes := cdsItensNFevalor_difal.AsFloat;

      If itemNFe.fltBasRet <> 0 Then
        itemNFe.fltAlqRet := itemNFe.fltValRet / itemNFe.fltBasRet * 100;

      itemNFe.strCstPis := cdsItensNFecst_pis.AsString;
      itemNFe.fltBasPis := cdsItensNFebase_pis.AsFloat;
      itemNFe.fltValPis := cdsItensNFevalor_pis.AsFloat;
      itemNFe.fltAlqPis := cdsItensNFealiquota_pis.AsFloat;

      itemNFe.strCstCof := cdsItensNFecst_cofins.AsString;
      itemNFe.fltBasCof := cdsItensNFebase_cofins.AsFloat;
      itemNFe.fltValCof := cdsItensNFevalor_cofins.AsFloat;
      itemNFe.fltAlqCof := cdsItensNFealiquota_cofins.AsFloat;
    End;

    fatVenda.objNfeComplemento.arrItensNFe[intItem] := itemNfe;
  End;

end;

end.

