unit ACBrNFeDANFEFR;

interface

uses
{$IF Defined(LINUX)}
  FMX.frxClass, FMX.frxBarcode2DView, FMX.frxBarcode, FMX.frxBarcod,
{$ELSE}
  frxClass, frxBarcode2D, ShellAPI, Windows,
{$IFEND}
  SysUtils, Classes, ACBrNFeDANFEClass, ACBrNFeDANFEFRDM,
  untNFe, untConversao, untUtil;

type
  EACBrNFeDANFEFR = class(Exception);
  {$IFDEF UNIDAC}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF UNIDAC}
  TACBrNFeDANFEFR = class( TACBrNFeDANFEClass )
   private
    FdmDanfe: TACBrNFeFRClass;
    FFastFile: String;
    FEspessuraBorda: Integer;
    FShowDialog: Boolean;
    FExibirTotalTributos: Boolean;
    FExibirTotalTributosItem: Boolean;
    FExibeCampoFatura: Boolean;
    FTributosFonte: string;
    FTributosPercentual: TPercentualTributos;
    FTributosPercentualPersonalizado: double;
    FMarcaDaguaMSG: string;
    FDetalhado: Boolean;
    FURLConsultaPublica:String;
    FDescricaoViaEstabelec: string;
    FImprimirUnQtVlComercial: TImprimirUnidQtdeValor;
    FExpandirDadosAdicionaisAuto: boolean;
    FImprimirDadosArma: Boolean;
    FExibirLocalEntrega: Boolean;
    FExibirLocalRetirada: Boolean;
    fQuebraLinhaEmDetalhamentoEspecifico : Boolean;
    FIncorporarFontesPdf: Boolean;
    FIncorporarBackgroundPdf: Boolean;
    FImprimirDadosDocReferenciados: Boolean;
    FPrintMode: TfrxPrintMode;
    FPrintOnSheet: Integer;
    FPreparouRelatorio: Boolean;
    function GetPreparedReport: TfrxReport;
    function PrepareReport(NFE: TNFe = nil): Boolean;
    procedure setTributosPercentual(const Value: TPercentualTributos);
    procedure setTributosPercentualPersonalizado(const Value: double);
    procedure pVerificaQrCodeVerso;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    property PreparedReport: TfrxReport read GetPreparedReport;
  published
    property FastFile: String read FFastFile write FFastFile;
    property dmDanfe: TACBrNFeFRClass read FdmDanfe write FdmDanfe;
    property EspessuraBorda: Integer read FEspessuraBorda write FEspessuraBorda;
    property ShowDialog: Boolean read FShowDialog write FShowDialog default false;
    property ExibirTotalTributos: Boolean read FExibirTotalTributos write FExibirTotalTributos;
    property ExibirTotalTributosItem: Boolean read FExibirTotalTributosItem write FExibirTotalTributosItem;
    property ExibeCampoFatura: Boolean read FExibeCampoFatura write FExibeCampoFatura;
    property TributosFonte: string read FTributosFonte write FTributosFonte;
    property TributosPercentual: TPercentualTributos read FTributosPercentual write setTributosPercentual;
    property TributosPercentualPersonalizado: double read FTributosPercentualPersonalizado write setTributosPercentualPersonalizado;
    property MarcaDaguaMSG: string read FMarcaDaguaMSG write FMarcaDaguaMSG;
    property ImprimirUnQtVlComercial: TImprimirUnidQtdeValor read FImprimirUnQtVlComercial write FImprimirUnQtVlComercial;
    property Detalhado: Boolean read FDetalhado write FDetalhado;
    property URLConsultaPublica:String read FURLConsultaPublica write FURLConsultaPublica;
    property DescricaoViaEstabelec: string read FDescricaoViaEstabelec write FDescricaoViaEstabelec;
    property ExpandirDadosAdicionaisAuto: boolean read FExpandirDadosAdicionaisAuto write FExpandirDadosAdicionaisAuto;
    property ImprimirDadosArma: Boolean read FImprimirDadosArma write FImprimirDadosArma;
    property ExibirLocalEntrega: Boolean read FExibirLocalEntrega write FExibirLocalEntrega;
    property ExibirLocalRetirada: Boolean read FExibirLocalRetirada write FExibirLocalRetirada;
    property QuebraLinhaEmDetalhamentoEspecifico : Boolean  read fQuebraLinhaEmDetalhamentoEspecifico Write fQuebraLinhaEmDetalhamentoEspecifico;
    property IncorporarBackgroundPdf: Boolean read FIncorporarBackgroundPdf write FIncorporarBackgroundPdf;
    property IncorporarFontesPdf: Boolean read FIncorporarFontesPdf write FIncorporarFontesPdf;
    property ImprimirDadosDocReferenciados: Boolean read FImprimirDadosDocReferenciados write FImprimirDadosDocReferenciados;
    property PrintMode: TfrxPrintMode read FPrintMode write FPrintMode default pmDefault;
    property PrintOnSheet: Integer read FPrintOnSheet write FPrintOnSheet default 0;
    property PreparouRelatorio: Boolean Read FPreparouRelatorio;
  end;

implementation

uses ACBrNFe, ACBrUtil, StrUtils, untConversaoNFe, untConfImpressora, untNfeDinamico, untNfsDinamico;

constructor TACBrNFeDANFEFR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FdmDanfe := TACBrNFeFRClass.Create(Self);
  FFastFile := '' ;
  FEspessuraBorda := 1;
  FExibirTotalTributos := False;
  FExibirTotalTributosItem := False;
  FExibeCampoFatura := True;
  FTributosFonte := '';
  FTributosPercentual := ptValorProdutos;
  FTributosPercentualPersonalizado := 0;
  FMarcaDaguaMSG:='';
  FImprimirUnQtVlComercial:=iuComercial;
  ExpandirDadosAdicionaisAuto:=false;
  { NFC-e }
  FvTroco := 0;
  FDetalhado := False;
  FDescricaoViaEstabelec := 'Via do Consumidor';// utilizado para NFC-e
  FURLConsultaPublica:= ''; //NFCe
  FImprimirDadosArma := True;
  FExibirLocalEntrega := True;
  FExibirLocalRetirada := True;
  fQuebraLinhaEmDetalhamentoEspecifico  := True;
  FIncorporarFontesPdf := True;
  FIncorporarBackgroundPdf := True;
  FImprimirDadosDocReferenciados := True;
  FPreparouRelatorio := False;
end;

destructor TACBrNFeDANFEFR.Destroy;
begin
  FdmDanfe.Free;
  inherited Destroy;
end;

function TACBrNFeDANFEFR.GetPreparedReport: TfrxReport;
begin
  if Trim(FFastFile) = '' then
    Result := nil
  else
  begin
    if PrepareReport(nil) then
      Result := FdmDanfe.frxReport
    else
      Result := nil;
  end;
end;


function TACBrNFeDANFEFR.PrepareReport(NFE: TNFe): Boolean;
var
  I: Integer;
  wProjectStream: TStringStream;
  Page: TfrxReportPage;
begin
  Result := False;

  if ViaConsumidor then
    FDescricaoViaEstabelec := 'Via Consumidor'
  else
    FDescricaoViaEstabelec := 'Via Estabelecimento';

  FdmDanfe.ExibirTotalTributos := FExibirTotalTributos;
  FdmDanfe.ExibirTotalTributosItem := FExibirTotalTributosItem;
  FdmDanfe.ExibeCampoFatura :=  FExibeCampoFatura;
  FdmDanfe.TributosFonte :=  FTributosFonte;
  FdmDanfe.TributosPercentual :=  FTributosPercentual;
  FdmDanfe.TributosPercentualPersonalizado :=  FTributosPercentualPersonalizado;
  FdmDanfe.MarcaDaguaMSG :=  FMarcaDaguaMSG;
  FdmDanfe.ImprimirUnQtVlComercial := FImprimirUnQtVlComercial;
  FdmDanfe.ExpandirDadosAdicionaisAuto := FExpandirDadosAdicionaisAuto;
  FdmDanfe.vTroco := FvTroco;
  FdmDanfe.Detalhado := FDetalhado;
  FdmDanfe.DescricaoViaEstabelec := FDescricaoViaEstabelec;
  FdmDanfe.URLConsultaPublica    := FURLConsultaPublica;
  FdmDanfe.ImprimirDadosArma := FImprimirDadosArma;
  FdmDanfe.ExibirLocalEntrega := FExibirLocalEntrega;
  FdmDanfe.ExibirLocalRetirada := FExibirLocalRetirada;
  FdmDanfe.QuebraLinhaEmDetalhamentoEspecifico := fQuebraLinhaEmDetalhamentoEspecifico;
  FdmDanfe.IncorporarBackgroundPdf := FIncorporarFontesPdf;
  FdmDanfe.IncorporarFontesPdf := FIncorporarBackgroundPdf;
  FdmDanfe.ImprimirDadosDocReferenciados := FImprimirDadosDocReferenciados;

  FdmDanfe.SetDataSetsToFrxReport;
  if Trim(FastFile) <> '' then
  begin
    if uppercase(copy(FastFile,length(FastFile)-3,4))='.FR3' then
    begin
      if FileExists(FastFile) then
        FdmDanfe.frxReport.LoadFromFile(FastFile)
      else
        raise EACBrNFeDANFEFR.CreateFmt('Caminho do arquivo de impressão do DANFE "%s" inválido.', [FastFile]);
    end
    else
    begin
      wProjectStream := fStringToStreamDanfe(FastFile);
      FdmDanfe.frxReport.FileName := '';
      FdmDanfe.frxReport.LoadFromStream(wProjectStream);
      wProjectStream.Free;
    end;
  end
  else
    raise EACBrNFeDANFEFR.Create('Caminho do arquivo de impressão do DANFE não assinalado.');

{$IF Defined(LINUX)}
  FdmDanfe.SetDataSetsToFrxReport;
{$IFEND}

  FdmDanfe.frxReport.PrintOptions.Copies := FNumCopias;
  FdmDanfe.frxReport.PrintOptions.ShowDialog := FShowDialog;
  FdmDanfe.frxReport.PrintOptions.PrintMode := FPrintMode; //Precisamos dessa propriedade porque impressoras não fiscais cortam o papel quando há muitos itens. O ajuste dela deve ser necessariamente após a carga do arquivo FR3 pois, antes da carga o componente é inicializado
  FdmDanfe.frxReport.PrintOptions.PrintOnSheet := FPrintOnSheet; //Essa propriedade pode trabalhar em conjunto com a printmode
  FdmDanfe.frxReport.ShowProgress := {$IFDEF LINUX}False{$ELSE}FMostrarStatus{$ENDIF};
  FdmDanfe.frxReport.PreviewOptions.AllowEdit := False;

  // Define a impressora
  if Length(Impressora) > 0 then
    FdmDanfe.frxReport.PrintOptions.Printer := FImpressora;

  // preparar relatorio
  if Assigned(NFE) then
  begin
    FdmDanfe.NFe := NFE;
    FdmDanfe.CarregaDadosNFe;

    Result := FdmDanfe.frxReport.PrepareReport;
  end
  else
  begin
    if Assigned(ACBrNFe) then
    begin
      for i := 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count - 1 do
      begin
        FdmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        FdmDanfe.CarregaDadosNFe;

        if (i > 0) then
          Result := FdmDanfe.frxReport.PrepareReport(False)
        else
          Result := FdmDanfe.frxReport.PrepareReport;
      end;
    end
    else
      raise EACBrNFeDANFEFR.Create('Propriedade ACBrNFe não assinalada.');
  end;

  if Assigned(FdmDanfe.NFe) and
    (FdmDanfe.NFe.Ide.modelo = 55) then
  Begin

    for i := 0 to FdmDanfe.frxReport.PreviewPages.Count - 1 do
    begin
      Page := FdmDanfe.frxReport.PreviewPages.Page[i];
      if MargemSuperior > 0 then
        Page.TopMargin    := MargemSuperior * 10;
      if MargemInferior > 0 then
        Page.BottomMargin := MargemInferior * 10;
      if MargemEsquerda > 0 then
        Page.LeftMargin   := MargemEsquerda * 10;
      if MargemDireita > 0 then
        Page.RightMargin  := MargemDireita * 10;
      FdmDanfe.frxReport.PreviewPages.ModifyPage(i, Page);
    end;

    FdmDanfe.frxReport.PrepareReport;
  end;

  FPreparouRelatorio := True;
end;

procedure TACBrNFeDANFEFR.setTributosPercentual(
  const Value: TPercentualTributos);
begin
  FTributosPercentual := Value;
  if Value <> ptPersonalizado then
    FTributosPercentualPersonalizado := 0;
end;

procedure TACBrNFeDANFEFR.setTributosPercentualPersonalizado(
  const Value: double);
begin
  if FTributosPercentual=ptPersonalizado then
    FTributosPercentualPersonalizado := Value
  else
    FTributosPercentualPersonalizado := 0;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFE(NFE: TNFe);
begin
  FDetalhado := True;

  if PrepareReport(NFE) then
  begin

    pVerificaQrCodeVerso();

    {PDF}
    If (FPDF_Gerar) Then
    Begin
      FdmDanfe.frxReport.EngineOptions.NewSilentMode := simReThrow;
      FdmDanfe.frxPDFExport.FileName   := FPDF_Diretorio;
      FdmDanfe.frxPDFExport.ShowDialog := False;

      FdmDanfe.frxReport.PrintOptions.ShowDialog := False;

      if (not FImprimirQrCode) then
      begin
      {$IF Defined(LINUX)}
        FdmDanfe.SetDataSetsToFrxReport;
        FdmDanfe.frxPDFExport.EmbeddedFonts := True;
      {$IFEND}
        FdmDanfe.frxReport.PrepareReport();
      end;

      FdmDanfe.frxReport.Export(FdmDanfe.frxPDFExport);

      If (FPDF_Apresentar) Then
      Begin
        if FileExists(FdmDanfe.frxPDFExport.FileName) then
        begin
         {$IF not defined(LINUX)}
          ShellExecute(0, nil, PChar(FdmDanfe.frxPDFExport.FileName), nil, nil, SW_SHOWNORMAL);
         {$IFEND}
        end
        else
        begin
          FdmDanfe.frxPDFExport.ShowDialog := True;
          pPreviewReport('NFeImpressao', 'NF-e ' + FchNFe, FdmDanfe.frxReport);
        end;
      End;

    End
    Else
    Begin
      if MostrarPreview then
        pPreviewReport('NFeImpressao', 'NF-e ' + FchNFe, FdmDanfe.frxReport)
      else
        pPrintReport('NFeImpressao', 'NF-e ' + FchNFe, FImpressora, FdmDanfe.frxReport);
    End;

  end
  else if Assigned(FdmDanfe.DinEntrada) then
    TNfsDinamico.pGravaLogDin('Erro NfeImpressao NFe Dinamico', FdmDanfe.DinEntrada.strAcesso,
      'Impressao dinamica da NF-e (provedor ' + FdmDanfe.DinEntrada.strProvedor +
      '): o relatorio nao foi preparado e a via nao foi impressa.', FdmDanfe.frxReport.Errors.Text);

end;

procedure TACBrNFeDANFEFR.pVerificaQrCodeVerso();
var
  objReport: TFrxReport;
  objPage: TfrxReportPage;
  objBand: TfrxBand;
  objQrCode: TfrxBarcode2DView;
begin
  if not FImprimirQrCode then
    Exit;

  if FQrCode = '' then
    Exit;

  objReport := TFrxReport.Create(Self);
  try
    objReport.Clear;

    objPage := TfrxReportPage.Create(objReport);
    objPage.CreateUniqueName;
    objPage.SetDefaults;

    objBand := TfrxReportTitle.Create(objPage);
    objBand.CreateUniqueName;
    objBand.Top := 0;
    objBand.Height := objPage.Height;
    objBand.Width := objPage.Width;

    objQrCode := TfrxBarcode2DView.Create(objBand);
    objQrCode.CreateUniqueName;
    objQrCode.BarType := bcCodeQR;
    objQrCode.ShowText := False;
    objQrCode.Text := FQrCode;
    objQrCode.Height := 200;
    objQrCode.Width := 200;
    objQrCode.Top := (objPage.Height / 2) - (objQrCode.Height / 2);
    objQrCode.Left := (objPage.Width / 2) - (objQrCode.Width / 2);

    objReport.PrepareReport;
    FdmDanfe.frxReport.PreviewPages.AddFrom(objReport);

    FdmDanfe.frxReport.PrintOptions.Duplex := dmVertical;
  finally
    FreeAndNil(objReport);
  end;
end;

end.
