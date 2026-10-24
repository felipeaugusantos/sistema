unit Contabilidade.View.ConfiguracoesImportacaoContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, UniClientDataSet, Vcl.ComCtrls, Contabilidade.Interfaces,
  cxCheckBox, cxTextEdit, Uni, System.Generics.Collections;

type
  TfrmConfiguracoesImportacaoContabil = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    cxgDados: TcxGridCitel;
    cxgDadosDBTableViewFolha: TcxGridDBTableViewCitel;
    cxgDadosDBTableViewFolhaCON_DTALAN: TcxGridDBColumn;
    cxgDadosDBTableViewFolhaTAMANH: TcxGridDBColumn;
    cxgDadosDBTableViewFolhaPOSINI: TcxGridDBColumn;
    cxgDadosDBTableViewFolhaCON_CCUSTO: TcxGridDBColumn;
    cxgDadosLevel1: TcxGridLevel;
    pgcCfgImportacaoContabil: TPageControl;
    tbsFolhaPagamento: TTabSheet;
    tbsPatrimonial: TTabSheet;
    dtsFolha: TDataSource;
    dtsPatrimonial: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridDBTableViewPatrimonial: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxgDadosDBTableViewPatrimonialTAMANH: TcxGridDBColumn;
    cxgDadosDBTableViewPatrimonialPOSINI: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    dtsDimob: TDataSource;
    tbsDimob: TTabSheet;
    cxGridCitelDimob: TcxGridCitel;
    cxGridDBTableViewDimob: TcxGridDBTableViewCitel;
    cxGridDBColumn5: TcxGridDBColumn;
    cxgDadosDBTableViewDimobPOSINI: TcxGridDBColumn;
    cxGridDBTableViewDimobTAMANH: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxgDadosDBTableViewFolhaLAY_SELECI: TcxGridDBColumn;
    cxGridDBTableViewPatrimonialLAY_SELECI: TcxGridDBColumn;
    cxGridDBTableViewDimobLAY_SELECI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgDadosDBTableViewFolhaCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableViewPatrimonialCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableViewDimobCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDadosDBTableViewFolhaLAY_SELECIPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxGridDBTableViewPatrimonialLAY_SELECIPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxGridDBTableViewDimobLAY_SELECIPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxgDadosDBTableViewFolhaEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure cxGridDBTableViewPatrimonialEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure cxGridDBTableViewDimobEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }
    FEspelhoContaContabil: TDictionary<string,string> ;
    cdsDadosFolha : TUniClientDataSet;
    cdsDadosPatrimonial : TUniClientDataSet;
    cdsDadosDimob : TUniClientDataSet;
    function fCriarCdsDados: TUniClientDataSet;
    procedure pPopularDados(cdsDados: TUniClientDataSet);
    procedure pAddRegistro(cdsDados: TUniClientDataSet; const ACodigoCampo: string;
      const ANomeCampo: string; const ATamanho, APosicaoInicial: Integer;
      const AObservacoes: string; ASelecionado: integer=1);
    procedure pGravar;
    procedure pGravarLayout(cdsDados: TUniClientDataSet; const ACodLay: string);
    procedure pDeletarLayoutsEmpresa;
    procedure pCarregarLayouts(cdsDados: TUniClientDataSet; Layout: TLayoutImportacaoContabil);
    function fValidouPreenchimento(cdsDados: TUniClientDataSet; var ACampoObrigatorio: boolean): boolean;
    procedure pSetCustomDrawCell(cdsDados: TUniClientDataSet; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo);
    function fTemParametroSelecionado(cdsDados: TUniClientDataSet): boolean;
    function fCampoParametroObrigatorio(const ANomeCampo:string; const ACds: TUniClientDataSet): boolean;
    function fParametroConfiguradoCorretamente(AcdsDados: TUniClientDataSet): boolean;
    procedure pMensagemParametro(const ANomeParametro, ACodigoParametro: string; const ACds: TUniClientDataSet; const ACampoObrigatorio: boolean) ;
    function fValorSelecionado(const AQryParametros:TUniQuery):integer ;
    procedure pReorganizaUnCheck(AGridTableView: TcxGridDBTableViewCitel; AColPosIni, AColTamanh: TcxGridDBColumn);
    procedure pReorganizaCheck(AGridTableView: TcxGridDBTableViewCitel; AColPosIni, AColTamanh, AColSeleci: TcxGridDBColumn);
    procedure pInverteContaContabilReduzida(AGridTableView: TcxGridDBTableViewCitel;
                                            AColPosIni, AColTamanh, AColSeleci: TcxGridDBColumn;
                                            const ANomeReg: string;
                                            const ATamanhoRegAnterior, APosicaoRegAnterior: integer;
                                            const AChecked: boolean);
    procedure pAjustaContaContabilReduzida(var AcdsDados: TUniClientDataSet; var APosIni: Integer);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Classes.Helpers, Contabilidade.Funcoes, StrUtils;

{$R *.dfm}

function fRetPosIni(pQuery: TUniQuery): integer;
var
  iAuxTanho : integer ;
begin
  result := 0 ;
  iAuxTanho := 0 ;
  pQuery.First ;
  while not pQuery.Eof do
  begin
    if pQuery.FieldByName('LAY_POSINI').AsInteger > Result then
    begin
      Result := pQuery.FieldByName('LAY_POSINI').AsInteger ;
      iAuxTanho := pQuery.FieldByName('LAY_TAMANH').AsInteger ;
    end;
    pQuery.Next ;
  end;
  Result := Result + iAuxTanho ;
end;

{ TfrmConfiguracoesImportacaoContabil }

procedure TfrmConfiguracoesImportacaoContabil.btnGravarClick(
  Sender: TObject);
var
  LblnCampoOrigatorio: boolean ;
begin
  inherited;

  if not fValidouPreenchimento(cdsDadosFolha, LblnCampoOrigatorio) then
  begin
    pgcCfgImportacaoContabil.ActivePage := tbsFolhaPagamento;
    pMensagemParametro(cdsDadosFolha.FieldByName('NOMCAM').AsString, cdsDadosFolha.FieldByName('CODCAM').AsString, cdsDadosFolha, LblnCampoOrigatorio) ;
    Exit;
  end;

  if not fValidouPreenchimento(cdsDadosPatrimonial, LblnCampoOrigatorio) then
  begin
    pgcCfgImportacaoContabil.ActivePage := tbsPatrimonial;
    pMensagemParametro(cdsDadosPatrimonial.FieldByName('NOMCAM').AsString, cdsDadosPatrimonial.FieldByName('CODCAM').AsString, cdsDadosPatrimonial, LblnCampoOrigatorio) ;
    Exit;
  end;

  if not fValidouPreenchimento(cdsDadosDimob, LblnCampoOrigatorio) then
  begin
    pgcCfgImportacaoContabil.ActivePage := tbsDimob;
    pMensagemParametro(cdsDadosDimob.FieldByName('NOMCAM').AsString, cdsDadosDimob.FieldByName('CODCAM').AsString, cdsDadosDimob, LblnCampoOrigatorio) ;
    Exit;
  end;

  if fMensagem('', 'Confirmar gravação dos layouts?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    pGravar;
    fMensagem('', 'Layouts gravados com sucesso!', ['&OK']);
    Self.Close;
  End;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxgDadosDBTableViewFolhaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pSetCustomDrawCell(cdsDadosFolha, ACanvas, AViewInfo);
end;

procedure TfrmConfiguracoesImportacaoContabil.cxgDadosDBTableViewFolhaEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if fCfgRpCtRd = 'S' then
  begin
    if AItem = cxgDadosDBTableViewFolhaLAY_SELECI then
    begin
      if AnsiMatchStr(cdsDadosFolha.FieldByName('CODCAM').AsString, ['CTRDDB', 'CTRDCR']) then
      begin
        AAllow := False ;
        fMensagem('', 'Parâmetro "CFG_RPCTRD - Permite Repetir Conta Reduzida no Plano de Contas?"'+#13+#10+'Deve ser desativado!', ['&OK']);
      end;
    end;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxgDadosDBTableViewFolhaLAY_SELECIPropertiesEditValueChanged(
  Sender: TObject);
var
  LStrCampo: string ;
  LTamanhoRegAnterior, LPosicaoRegAnterior: integer ;
begin
  inherited;
  if fColunaExisteSeleci then
  begin
    cxgDadosDBTableViewFolha.DataController.PostEditingData ;
    cxgDadosDBTableViewFolhaLAY_SELECI.DataBinding.Field.AsInteger := iif(TcxCheckBox(Sender).Checked, 1, 0) ;
    //cxgDadosDBTableViewFolha.DataController.DataSet.Post ;
    LStrCampo := cxgDadosDBTableViewFolha.DataController.DataSet.FieldByName('CODCAM').AsString ;
    LTamanhoRegAnterior := cxgDadosDBTableViewFolha.DataController.DataSet.FieldByName('TAMANH').AsInteger ;
    LPosicaoRegAnterior := cxgDadosDBTableViewFolha.DataController.DataSet.FieldByName('POSINI').AsInteger ;

    if (not FEspelhoContaContabil.ContainsKey(LStrCampo)) or (not TcxCheckBox(Sender).Checked) then
    begin
      if not TcxCheckBox(Sender).Checked then
      begin
        pReorganizaUnCheck(cxgDadosDBTableViewFolha, cxgDadosDBTableViewFolhaPOSINI, cxgDadosDBTableViewFolhaTAMANH);
      end
      else
      begin
        pReorganizaCheck(cxgDadosDBTableViewFolha, cxgDadosDBTableViewFolhaPOSINI, cxgDadosDBTableViewFolhaTAMANH, cxgDadosDBTableViewFolhaLAY_SELECI);
      end;
      exit ;
    end;

    ////desmarca a conta reduzida e vice versa
    pInverteContaContabilReduzida(cxgDadosDBTableViewFolha,
                                  cxgDadosDBTableViewFolhaPOSINI,
                                  cxgDadosDBTableViewFolhaTAMANH,
                                  cxgDadosDBTableViewFolhaLAY_SELECI,
                                  LStrCampo,
                                  LTamanhoRegAnterior,
                                  LPosicaoRegAnterior,
                                  TcxCheckBox(Sender).Checked) ;

  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewDimobCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pSetCustomDrawCell(cdsDadosDimob, ACanvas, AViewInfo);
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewDimobEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if fCfgRpCtRd = 'S' then
  begin
    if AItem = cxGridDBTableViewDimobLAY_SELECI then
    begin
      if AnsiMatchStr(cdsDadosDimob.FieldByName('CODCAM').AsString, ['CTRDDB', 'CTRDCR']) then
      begin
        AAllow := False ;
        fMensagem('', 'Parâmetro "CFG_RPCTRD - Permite Repetir Conta Reduzida no Plano de Contas?"'+#13+#10+'Deve ser desativado!', ['&OK']);
      end;
    end;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewDimobLAY_SELECIPropertiesEditValueChanged(
  Sender: TObject);
var
  LStrCampo: string ;
  LTamanhoRegAnterior, LPosicaoRegAnterior: integer ;
begin
  inherited;
  if fColunaExisteSeleci then
  begin
    cxGridDBTableViewDimob.DataController.PostEditingData ;
    cxGridDBTableViewDimobLAY_SELECI.DataBinding.Field.AsInteger := iif(TcxCheckBox(Sender).Checked, 1, 0) ;
    LStrCampo := cxGridDBTableViewDimob.DataController.DataSet.FieldByName('CODCAM').AsString ;
    LTamanhoRegAnterior := cxGridDBTableViewDimob.DataController.DataSet.FieldByName('TAMANH').AsInteger ;
    LPosicaoRegAnterior := cxGridDBTableViewDimob.DataController.DataSet.FieldByName('POSINI').AsInteger ;

    if not FEspelhoContaContabil.ContainsKey(LStrCampo) then
    begin
      if not TcxCheckBox(Sender).Checked then
      begin
        pReorganizaUnCheck(cxGridDBTableViewDimob, cxgDadosDBTableViewDimobPOSINI, cxGridDBTableViewDimobTAMANH);
      end
      else
      begin
        pReorganizaCheck(cxGridDBTableViewDimob, cxgDadosDBTableViewDimobPOSINI, cxGridDBTableViewDimobTAMANH, cxGridDBTableViewDimobLAY_SELECI);
      end;
    end;

    ////desmarca a conta reduzida e vice versa
    pInverteContaContabilReduzida(cxGridDBTableViewDimob,
                                  cxgDadosDBTableViewDimobPOSINI,
                                  cxGridDBTableViewDimobTAMANH,
                                  cxGridDBTableViewDimobLAY_SELECI,
                                  LStrCampo,
                                  LTamanhoRegAnterior,
                                  LPosicaoRegAnterior,
                                  TcxCheckBox(Sender).Checked) ;

  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewPatrimonialCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pSetCustomDrawCell(cdsDadosPatrimonial, ACanvas, AViewInfo);
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewPatrimonialEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if fCfgRpCtRd = 'S' then
  begin
    if AItem = cxGridDBTableViewPatrimonialLAY_SELECI then
    begin
      if AnsiMatchStr(cdsDadosPatrimonial.FieldByName('CODCAM').AsString, ['CTRDDB', 'CTRDCR']) then
      begin
        AAllow := False ;
        fMensagem('', 'Parâmetro "CFG_RPCTRD - Permite Repetir Conta Reduzida no Plano de Contas?"'+#13+#10+'Deve ser desativado!', ['&OK']);
      end;
    end;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.cxGridDBTableViewPatrimonialLAY_SELECIPropertiesEditValueChanged(
  Sender: TObject);
var
  LStrCampo: string ;
  LTamanhoRegAnterior, LPosicaoRegAnterior: integer ;
begin
  inherited;
  if fColunaExisteSeleci then
  begin
    cxGridDBTableViewPatrimonial.DataController.PostEditingData ;
    cxGridDBTableViewPatrimonialLAY_SELECI.DataBinding.Field.AsInteger := iif(TcxCheckBox(Sender).Checked, 1, 0) ;
    LStrCampo := cxGridDBTableViewPatrimonial.DataController.DataSet.FieldByName('CODCAM').AsString ;
    LTamanhoRegAnterior := cxGridDBTableViewPatrimonial.DataController.DataSet.FieldByName('TAMANH').AsInteger ;
    LPosicaoRegAnterior := cxGridDBTableViewPatrimonial.DataController.DataSet.FieldByName('POSINI').AsInteger ;

    if not FEspelhoContaContabil.ContainsKey(LStrCampo) then
    begin
      if not TcxCheckBox(Sender).Checked then
      begin
        pReorganizaUnCheck(cxGridDBTableViewPatrimonial, cxgDadosDBTableViewPatrimonialPOSINI, cxgDadosDBTableViewPatrimonialTAMANH);
      end
      else
      begin
        pReorganizaCheck(cxGridDBTableViewPatrimonial, cxgDadosDBTableViewPatrimonialPOSINI, cxgDadosDBTableViewPatrimonialTAMANH, cxGridDBTableViewPatrimonialLAY_SELECI);
      end;
    end;

        ////desmarca a conta reduzida e vice versa
    pInverteContaContabilReduzida(cxGridDBTableViewPatrimonial,
                                  cxgDadosDBTableViewPatrimonialPOSINI,
                                  cxgDadosDBTableViewPatrimonialTAMANH,
                                  cxGridDBTableViewPatrimonialLAY_SELECI,
                                  LStrCampo,
                                  LTamanhoRegAnterior,
                                  LPosicaoRegAnterior,
                                  TcxCheckBox(Sender).Checked) ;

  end;
end;

function TfrmConfiguracoesImportacaoContabil.fCampoParametroObrigatorio(
  const ANomeCampo: string; const ACds: TUniClientDataSet): boolean;
var
  cdsAux: TUniClientDataSet ;
begin
  result := pos(ANomeCampo, 'CODEMP_DTALAN_HISTOR_VALLAN') > 0 ;
  ///verifica se a conta espelho está selecionada
  if FEspelhoContaContabil.ContainsKey(ANomeCampo) then
  begin
    cdsAux := TUniClientDataSet.Create(Nil);
    try
      cdsAux.Data := ACds.Data;
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'CODCAM = ' + QuotedStr(FEspelhoContaContabil.Items[ANomeCampo]);
      cdsAux.Filtered := True;
      if cdsAux.FieldByName('SELECI').AsInteger = 0 then
      begin
        result := True ;
      end;
    finally
      FreeAndNil(cdsAux) ;
    end;
  end;
end;

function TfrmConfiguracoesImportacaoContabil.fCriarCdsDados: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  Result.FieldDefs.Add('CODCAM', ftString,  6, False);
  Result.FieldDefs.Add('NOMCAM', ftString, 60, False);
  Result.FieldDefs.Add('TAMANH', ftInteger, 0, False);
  Result.FieldDefs.Add('POSINI', ftInteger, 0, False);
  Result.FieldDefs.Add('OBSERV', ftString, 150, False);
  if fColunaExisteSeleci then
  begin
    Result.FieldDefs.Add('SELECI', ftInteger, 0, False);
  end;
  Result.CreateDataSet;
  Result.Open;
end;

procedure TfrmConfiguracoesImportacaoContabil.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDadosFolha := fCriarCdsDados;
  cdsDadosFolha.IndexFieldNames := 'POSINI' ;
  cdsDadosPatrimonial := fCriarCdsDados;
  cdsDadosPatrimonial.IndexFieldNames := 'POSINI' ;
  cdsDadosDimob := fCriarCdsDados;
  cdsDadosDimob.IndexFieldNames := 'POSINI' ;
  dtsFolha.DataSet := cdsDadosFolha;
  dtsPatrimonial.DataSet := cdsDadosPatrimonial;
  dtsDimob.DataSet := cdsDadosDimob;
  pgcCfgImportacaoContabil.ActivePageIndex := 0;
  FEspelhoContaContabil := TDictionary<string,string>.Create ;
  FEspelhoContaContabil.Add('CONCRE', 'CTRDCR');
  FEspelhoContaContabil.Add('CONDEB', 'CTRDDB');
  FEspelhoContaContabil.Add('CTRDCR', 'CONCRE');
  FEspelhoContaContabil.Add('CTRDDB', 'CONDEB');
end;

procedure TfrmConfiguracoesImportacaoContabil.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDadosFolha);
  FreeAndNil(cdsDadosPatrimonial);
  FreeAndNil(cdsDadosDimob);
  FreeAndNil(FEspelhoContaContabil) ;
end;

procedure TfrmConfiguracoesImportacaoContabil.FormShow(Sender: TObject);
begin
  inherited;
  if not fColunaExisteSeleci then
  begin
    cxgDadosDBTableViewFolhaLAY_SELECI.DataBinding.FieldName := '' ;
    cxGridDBTableViewPatrimonialLAY_SELECI.DataBinding.FieldName := '' ;
    cxGridDBTableViewDimobLAY_SELECI.DataBinding.FieldName := '' ;
    cxgDadosDBTableViewFolhaLAY_SELECI.Visible := False ;
    cxGridDBTableViewPatrimonialLAY_SELECI.Visible := False ;
    cxGridDBTableViewDimobLAY_SELECI.Visible := False ;
    cxgDadosDBTableViewFolhaLAY_SELECI.VisibleForCustomization := False ;
    cxGridDBTableViewPatrimonialLAY_SELECI.VisibleForCustomization := False ;
    cxGridDBTableViewDimobLAY_SELECI.VisibleForCustomization := False ;
  end;

  pCarregarLayouts(cdsDadosFolha, tLayFolha);
  pCarregarLayouts(cdsDadosPatrimonial, tLayPatrimonial);
  pCarregarLayouts(cdsDadosDimob, tLayDimob);
end;

function TfrmConfiguracoesImportacaoContabil.fParametroConfiguradoCorretamente(
  AcdsDados: TUniClientDataSet): boolean;
begin
  Result := true ;
  if AcdsDados.FieldByName('POSINI').AsInteger <= 0 then
    Exit(False);

  if AcdsDados.FieldByName('TAMANH').AsInteger <= 0 then
    Exit(False);
end;

function TfrmConfiguracoesImportacaoContabil.fTemParametroSelecionado(
  cdsDados: TUniClientDataSet): boolean;
var
  blnTemParametro: boolean ;
begin
  blnTemParametro := False ;
  /////verifica se há algum parametro selecionado
  cdsDados.First;
  while not cdsDados.Eof do
  begin
    if cdsDados.FieldByName('SELECI').AsInteger > 0 then
    begin
      blnTemParametro := True ;
      break ;
    end;
    cdsDados.Next;
  end;
  result := blnTemParametro ;
end;

function TfrmConfiguracoesImportacaoContabil.fValidouPreenchimento(
  cdsDados: TUniClientDataSet; var ACampoObrigatorio: boolean): boolean;
var
  blnParametroSelecionado: boolean ;
begin
  Result := True;
  ACampoObrigatorio := False ;
  if fColunaExisteSeleci then
  begin
    blnParametroSelecionado := fTemParametroSelecionado(cdsDados) ;
    if blnParametroSelecionado then
    begin
      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if cdsDados.FieldByName('SELECI').AsInteger > 0 then
        begin
          if not fParametroConfiguradoCorretamente(cdsDados) then
          begin
            Exit(False);
          end;
        end
        else
        begin
          ////verifica se é campo obrigatorio
          if fCampoParametroObrigatorio(cdsDados.FieldByName('CODCAM').AsString, cdsDados) then
          begin
             ACampoObrigatorio := True ;
             Exit(False);
          end;
          ////
        end;
        cdsDados.Next;
      end;
    end;
  end
  else
  begin
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      if not fParametroConfiguradoCorretamente(cdsDados) then
      begin
        Exit(False);
      end;
      cdsDados.Next;
    end;
  end;
end;

function TfrmConfiguracoesImportacaoContabil.fValorSelecionado(
  const AQryParametros: TUniQuery): integer;
begin
  if fColunaExisteSeleci then
  begin
    result := AQryParametros.FieldByName('LAY_SELECI').AsInteger ;
  end
  else
  begin
    result :=  1 ;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pAddRegistro(cdsDados: TUniClientDataSet; const ACodigoCampo: string;
      const ANomeCampo: string; const ATamanho, APosicaoInicial: Integer;
      const AObservacoes: string; ASelecionado: integer);
begin
  cdsDados.Append;
  cdsDados.FieldByName('CODCAM').AsString := ACodigoCampo;
  cdsDados.FieldByName('NOMCAM').AsString := ANomeCampo;
  cdsDados.FieldByName('TAMANH').AsInteger := ATamanho;
  cdsDados.FieldByName('POSINI').AsInteger := APosicaoInicial;
  cdsDados.FieldByName('OBSERV').AsString := AObservacoes;
  if fColunaExisteSeleci then
  begin
    cdsDados.FieldByName('SELECI').AsInteger := ASelecionado;
  end;
  cdsDados.Post;
end;

procedure TfrmConfiguracoesImportacaoContabil.pAjustaContaContabilReduzida(
  var AcdsDados: TUniClientDataSet; var APosIni: Integer);
begin

  if fCfgRpCtRd = 'N' then
  begin
    if not AcdsDados.Locate('CODCAM', 'CTRDDB', [loCaseInsensitive] ) then
    begin
      pAddRegistro(AcdsDados, 'CTRDDB', 'Conta Reduzida de Débito', 20, APosIni, '', 0);
      APosIni := APosIni + 20 ;
    end;
    if not AcdsDados.Locate('CODCAM', 'CTRDCR', [loCaseInsensitive] ) then
    begin
      pAddRegistro(AcdsDados, 'CTRDCR', 'Conta Reduzida de Crédito', 20, APosIni, '', 0);
    end;
  end
  else /// desmarcar caso o usuario mude a configuracao
  begin
    if fColunaExisteSeleci then
    begin
      if AcdsDados.Locate('CODCAM', 'CTRDDB', [loCaseInsensitive] ) then
      begin
        AcdsDados.Edit ;
        AcdsDados.FieldByName('SELECI').AsInteger := 0;
        AcdsDados.Post ;
      end;
      if AcdsDados.Locate('CODCAM', 'CTRDCR', [loCaseInsensitive] ) then
      begin
        AcdsDados.Edit ;
        AcdsDados.FieldByName('SELECI').AsInteger := 0;
        AcdsDados.Post ;
      end;
    end;
  end;

end;

procedure TfrmConfiguracoesImportacaoContabil.pCarregarLayouts(cdsDados: TUniClientDataSet; Layout: TLayoutImportacaoContabil);
  var
    qryDados : TUniQuery;
    iPosIni : integer ;
    intSelecionado : integer ;
begin
  qryDados := fCriaQuery(Self);
  try
    cdsDados.EmptyDataSet;
    qryDados.SQL.Text := 'SELECT * FROM LYCONT WHERE LAY_CODEMP = :CODEMP AND LAY_CODLAY = :CODLAY';
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.ParamByName('CODLAY').AsString := Layout.toCodigo;
    qryDados.Open;

    if (not qryDados.IsEmpty) then
    begin
      qryDados.First;
      while not qryDados.Eof Do
      begin
        intSelecionado :=  fValorSelecionado(qryDados) ;

        pAddRegistro(cdsDados,
                     qryDados.FieldByName('LAY_CODCAM').AsString,
                     qryDados.FieldByName('LAY_NOMCAM').AsString,
                     qryDados.FieldByName('LAY_TAMANH').AsInteger,
                     qryDados.FieldByName('LAY_POSINI').AsInteger,
                     qryDados.FieldByName('LAY_OBSERV').AsString,
                     intSelecionado);

        qryDados.Next;
      end;
      intSelecionado :=  fValorSelecionado(qryDados) ;
      //////Adiciona o registro CodHpd caso não tenha
      iPosIni := fRetPosIni(qryDados) ;
      if not fTemLinhaCodHpd(Layout) then
      begin
        if not cdsDados.Locate('CODCAM', 'CODHPD', [loCaseInsensitive] ) then
        begin
          pAddRegistro(cdsDados, 'CODHPD', 'Código Histórico Padrão', 5, iPosIni, '', intSelecionado);
          iPosIni := iPosIni + 5 ;
        end;
      end;

      pAjustaContaContabilReduzida(cdsDados, iPosIni) ;

    end
    else
      pPopularDados(cdsDados);
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pDeletarLayoutsEmpresa;
  var
    qryDados : TUniQuery;
begin
  qryDados := fCriaQuery(Self);
  try
    qryDados.SQL.Text := 'DELETE FROM LYCONT WHERE LAY_CODEMP = :CODEMP';
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.ExecSQL;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pGravar;
begin
  fStartTransaction;
  try
    pDeletarLayoutsEmpresa;
    pGravarLayout(cdsDadosFolha, tLayFolha.toCodigo);
    pGravarLayout(cdsDadosPatrimonial, tLayPatrimonial.toCodigo);
    pGravarLayout(cdsDadosDimob, tLayDimob.toCodigo);
    fCommit;
  except
    On E: Exception do
    begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmConfiguracoesImportacaoContabil.pGravar]');
    end;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pGravarLayout(
  cdsDados: TUniClientDataSet; const ACodLay: string);
  var
    qryDados : TUniQuery;
begin
  qryDados := fCriaQuery(Self);
  try
    qryDados.SQL.Text := 'SELECT * FROM LYCONT WHERE FALSE';
    qryDados.Open;

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      qryDados.Insert;
      qryDados.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LYCONT', VS_strCodEmp);
      qryDados.FieldByName('LAY_CODLAY').AsString := ACodLay;
      qryDados.FieldByName('LAY_CODEMP').AsString := VS_strCodEmp;
      qryDados.FieldByName('LAY_CODCAM').AsString := cdsDados.FieldByName('CODCAM').AsString;
      qryDados.FieldByName('LAY_NOMCAM').AsString := cdsDados.FieldByName('NOMCAM').AsString;
      qryDados.FieldByName('LAY_TAMANH').AsInteger := cdsDados.FieldByName('TAMANH').AsInteger;
      qryDados.FieldByName('LAY_POSINI').AsInteger := cdsDados.FieldByName('POSINI').AsInteger;
      qryDados.FieldByName('LAY_OBSERV').AsString := cdsDados.FieldByName('OBSERV').AsString;
      if fColunaExisteSeleci then
      begin
        qryDados.FieldByName('LAY_SELECI').AsInteger := cdsDados.FieldByName('SELECI').AsInteger;
      end;
      qryDados.Post;
      cdsDados.Next;
    end;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pInverteContaContabilReduzida(
  AGridTableView: TcxGridDBTableViewCitel;
  AColPosIni, AColTamanh, AColSeleci: TcxGridDBColumn;
  const ANomeReg: string;
  const ATamanhoRegAnterior, APosicaoRegAnterior: integer;
  const AChecked: boolean);
var
  LBlnSel: boolean ;
  LTamanhoRegAtual, LPosicaoRegAtual: integer;
begin

  if not AChecked then
  begin
    exit ;
  end;

  if FEspelhoContaContabil.ContainsKey(ANomeReg) then
  begin
    LBlnSel := not AChecked  ;

    ///valor atual
    if AGridTableView.DataController.DataSet.Locate('CODCAM', FEspelhoContaContabil.Items[ANomeReg], [loCaseInsensitive]) then
    begin
      if (AChecked) and (AColSeleci.DataBinding.Field.AsInteger = 0) then
      begin
        AGridTableView.DataController.DataSet.Locate('CODCAM', ANomeReg, [loCaseInsensitive]) ;
        if not AChecked then
        begin
          pReorganizaUnCheck(AGridTableView, AColPosIni, AColTamanh);
        end
        else
        begin
          pReorganizaCheck(AGridTableView, AColPosIni, AColTamanh, AColSeleci);
        end;
        exit ;
      end;

      LTamanhoRegAtual := AGridTableView.DataController.DataSet.FieldByName('TAMANH').AsInteger ;
      LPosicaoRegAtual := AGridTableView.DataController.DataSet.FieldByName('POSINI').AsInteger ;

      AGridTableView.DataController.DataSet.Edit ;
      AColSeleci.DataBinding.Field.AsInteger := iif(LBlnSel, 1, 0) ;
      AGridTableView.DataController.DataSet.FieldByName('TAMANH').AsInteger := ATamanhoRegAnterior ;
      AGridTableView.DataController.DataSet.FieldByName('POSINI').AsInteger := APosicaoRegAnterior ;
      AGridTableView.DataController.DataSet.Post ;

      if AGridTableView.DataController.DataSet.Locate('CODCAM', ANomeReg, [loCaseInsensitive]) then
      begin
        AGridTableView.DataController.DataSet.Edit ;
        AGridTableView.DataController.DataSet.FieldByName('TAMANH').AsInteger := LTamanhoRegAtual ;
        AGridTableView.DataController.DataSet.FieldByName('POSINI').AsInteger := LPosicaoRegAtual ;
        AGridTableView.DataController.DataSet.Post ;
      end;

      ///para deixar o foco no registro correto
      AGridTableView.DataController.DataSet.Locate('CODCAM', FEspelhoContaContabil.Items[ANomeReg], [loCaseInsensitive]) ;
    end;

  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pMensagemParametro(
  const ANomeParametro, ACodigoParametro: string; const ACds: TUniClientDataSet; const ACampoObrigatorio: boolean);
var
  cdsAux: TUniClientDataSet ;
  LNomeParametro: string ;
begin
  if ACampoObrigatorio then
  begin
    LNomeParametro := ANomeParametro ;
    if FEspelhoContaContabil.ContainsKey(ACodigoParametro) then
    begin
      cdsAux := TUniClientDataSet.Create(Nil);
      try
        cdsAux.Data := ACds.Data;
        cdsAux.Filtered := False;
        cdsAux.Filter   := 'CODCAM = ' + QuotedStr(FEspelhoContaContabil.Items[ACodigoParametro]);
        cdsAux.Filtered := True;
        LNomeParametro := LNomeParametro + ' ou ' + cdsAux.FieldByName('NOMCAM').AsString ;
      finally
        FreeAndNil(cdsAux) ;
      end;
    end;
    fMensagem('', 'Parâmetro "'+LNomeParametro+'" obrigatório, deve ser selecionado!', ['&OK']);
  end
  else
  begin
    fMensagem('', 'Parâmetro "'+ANomeParametro+'" deve ser preenchido com valores inteiros válidos nas colunas "posição inicial" e "tamanho"!', ['&OK']);
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pPopularDados(cdsDados: TUniClientDataSet);
begin
  pAddRegistro(cdsDados, 'CODEMP', 'Empresa', 3, 0, '', 0);
  pAddRegistro(cdsDados, 'DTALAN', 'Data Lançamento', 8, 0, 'Enviar no formato AAAAMMDD', 0);
  pAddRegistro(cdsDados, 'CONDEB', 'Conta de Débito', 20, 0, '', 0);
  pAddRegistro(cdsDados, 'CONCRE', 'Conta de Crédito', 20, 0, '', 0);
  pAddRegistro(cdsDados, 'HISTOR', 'Histórico', 200, 0, '', 0);
  pAddRegistro(cdsDados, 'VALLAN', 'Valor do Lançamento', 14, 0, 'Enviar no formato 99999999999999. Será considerado 2 decimais.', 0);
  pAddRegistro(cdsDados, 'CCUDEB', 'Centro de Custo de Débito', 5, 0, '', 0);
  pAddRegistro(cdsDados, 'CCUCRE', 'Centro de Custo de Crédito', 5, 0, '', 0);
  pAddRegistro(cdsDados, 'CODHPD', 'Código Histórico Padrão', 5, 0, '', 0);
  if fCfgRpCtRd = 'N' then
  begin
    pAddRegistro(cdsDados, 'CTRDDB', 'Conta Reduzida de Débito', 20, 0, '', 0);
    pAddRegistro(cdsDados, 'CTRDCR', 'Conta Reduzida de Crédito', 20, 0, '', 0);
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pReorganizaCheck(
  AGridTableView: TcxGridDBTableViewCitel; AColPosIni, AColTamanh,
  AColSeleci: TcxGridDBColumn);
var
  strBookMark : string ;
  intPosicaoInicial, intTamanho, intPosicao : integer ;
  lstReorganiza: TStringList ;
  strReorganiza: string ;
  intCnt: integer ;
begin
  strBookMark := AGridTableView.DataController.DataSet.FieldByName('CODCAM').AsString ;
  lstReorganiza := TStringList.Create ;
  try
    ///se a anterior estiver marcada não faz nada
    AGridTableView.DataController.DataSet.Prior ;
    if not AGridTableView.DataController.DataSet.Bof then
    begin
      if AColSeleci.DataBinding.Field.AsInteger = 0 then
      begin
        ///procura a ultima selecionada
        intPosicaoInicial := 1 ;
        intTamanho := 0 ;
        AGridTableView.DataController.DataSet.First ;
        while not AGridTableView.DataController.DataSet.Eof do
        begin
          if AColSeleci.DataBinding.Field.AsInteger = 1 then
          begin
            if strBookMark <> AGridTableView.DataController.DataSet.FieldByName('CODCAM').AsString then
            begin
              intPosicaoInicial := AColPosIni.DataBinding.Field.AsInteger ;
              intTamanho := AColTamanh.DataBinding.Field.AsInteger ;
            end;
          end
          else
          begin
            strReorganiza := AGridTableView.DataController.DataSet.FieldByName('CODCAM').AsString ;
            lstReorganiza.Add(strReorganiza) ;
          end;
          AGridTableView.DataController.DataSet.Next ;
        end;
        AGridTableView.DataController.DataSet.Locate('CODCAM', strBookMark, [loCaseInsensitive]);
        AGridTableView.DataController.DataSet.Edit ;
        AColPosIni.DataBinding.Field.AsInteger := intPosicaoInicial + intTamanho;
        AGridTableView.DataController.DataSet.Post ;
        intPosicao := AColPosIni.DataBinding.Field.AsInteger + AColTamanh.DataBinding.Field.AsInteger ;
        for intCnt := 0 to lstReorganiza.Count-1 do
        begin
          if AGridTableView.DataController.DataSet.Locate('CODCAM', lstReorganiza.Strings[intCnt], [loCaseInsensitive]) then
          begin
            if AColPosIni.DataBinding.Field.AsInteger = 0 then
            begin
              break ;
            end;
            AGridTableView.DataController.DataSet.Edit ;
            AColPosIni.DataBinding.Field.AsInteger := intPosicao ;
            AGridTableView.DataController.DataSet.Post ;
            intPosicao := AColPosIni.DataBinding.Field.AsInteger + AColTamanh.DataBinding.Field.AsInteger ;
          end;
        end;
      end;
    end;
    AGridTableView.DataController.DataSet.Locate('CODCAM', strBookMark, [loCaseInsensitive]);
  finally
    FreeAndNil(lstReorganiza) ;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pReorganizaUnCheck(
  AGridTableView: TcxGridDBTableViewCitel; AColPosIni,
  AColTamanh: TcxGridDBColumn);
var
  strBookMark : string ;
  intPosicaoInicial, intTamanho, intTamanhoDescontar: integer ;
  lstReorganiza: TStringList ;
  strReorganiza: string ;
  intCnt: integer ;
begin
  lstReorganiza := TStringList.Create ;
  strBookMark := AGridTableView.DataController.DataSet.FieldByName('CODCAM').AsString ;
  intTamanhoDescontar := AColTamanh.DataBinding.Field.AsInteger ;
  try
    while not AGridTableView.DataController.DataSet.Eof do
    begin
      strReorganiza := AGridTableView.DataController.DataSet.FieldByName('CODCAM').AsString ;
      lstReorganiza.Add(strReorganiza) ;
      AGridTableView.DataController.DataSet.Next ;
    end;
    intPosicaoInicial := AColPosIni.DataBinding.Field.AsInteger ;
    intTamanho := AColTamanh.DataBinding.Field.AsInteger ;

    AGridTableView.DataController.DataSet.Locate('CODCAM', strBookMark, [loCaseInsensitive]);
    AGridTableView.DataController.DataSet.Edit ;
    AColPosIni.DataBinding.Field.AsInteger := intPosicaoInicial + intTamanho;
    AGridTableView.DataController.DataSet.Post ;
    //desconta o tamanho da posição inicial
    for intCnt := 0 to lstReorganiza.Count-1 do
    begin
      if AGridTableView.DataController.DataSet.Locate('CODCAM', lstReorganiza.Strings[intCnt], [loCaseInsensitive]) then
      begin
        AGridTableView.DataController.DataSet.Edit ;
        AColPosIni.DataBinding.Field.AsInteger := AColPosIni.DataBinding.Field.AsInteger - intTamanhoDescontar;
        AGridTableView.DataController.DataSet.Post ;
      end;
    end;
  finally
    FreeAndNil(lstReorganiza) ;
  end;
end;

procedure TfrmConfiguracoesImportacaoContabil.pSetCustomDrawCell(
  cdsDados: TUniClientDataSet; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo);
begin
  If (Not Assigned(cdsDados)) Then
    Exit;

  If (Not cdsDados.Active) Then
    Exit;

  If AViewInfo.Item.Options.Editing Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;
  End
  Else
    ACanvas.Font.Color := clBlack;
end;

end.
