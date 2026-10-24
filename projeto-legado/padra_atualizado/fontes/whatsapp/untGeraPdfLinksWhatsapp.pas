unit untGeraPdfLinksWhatsapp;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  FMX.Objects,
  FMX.Graphics,
  Xml.XMLDoc,
  Xml.XMLIntf,
{$ELSE}
  untFuncoesSimples,
  Vcl.Graphics,
  untImagemBase64,
  frxClass,
  frxExportPDF,
{$ENDIF LINUX}
  System.Classes,
  System.SysUtils,
  untTypesSistema,
  System.NetEncoding,
  System.IOUtils,
  untFuncoesGenerica,
  System.StrUtils,
  Uni,
  Data.DB;

function fGerarPdfLinksWhatsappBase64(const ARecArquivos: TArray<TRecArquivosGatilhos>; AblnRetornarBase64: Boolean = True): String;

implementation

{$IFDEF LINUX}


procedure pImagemFromBase64(const strBase64: string; var objPicture : FMX.Graphics.TBitmap);
var
  LInput: TStringStream;
  LOutput: TMemoryStream;
begin
  LInput := TStringStream.Create;
  try
    LInput.WriteString(strBase64);
    LOutput := TMemoryStream.Create;
    try
      LInput.Position := 0;
      TNetEncoding.Base64.Decode(LInput, LOutput);
      LOutput.Position := 0;
      objPicture.LoadFromStream(LOutput);
    finally
      LOutput.Free;
    end;
  finally
    LInput.Free;
  end;
end;

function fGerarPdfLinksWhatsappBase64(
  const ARecArquivos: TArray<TRecArquivosGatilhos>;
  AblnRetornarBase64: Boolean = True): string;
const
  SQL_FR3 =
    ' SELECT '+
    '   LAY_ARQFR3 '+
    ' FROM'+
    '   LAYFR3 '+
    ' WHERE '+
    '   LAY_NOMFOR = "TfrmAnexoLinksWhatsapp" AND '+
    '   LAY_NOMLAY = "frxPdfLinksWhatsapp" ';
var
  qryFr3: TUniQuery;
  Html, CardsHtml: string;
  ImgBase64Logo,
  ImgBase64Titulo: string;
  TxtTitulo,
  TxtSubTitulo: string;
  i: Integer;
  arrInfoArquivo: TArray<string>;
begin
  Result := '';

  // Logo (Base64)
  ImgBase64Logo := fCampoTabela(
    'EMP_IMGB64',
    'EMPIMG',
    ['EMP_CODEMP', 'EMP_PRINCI'],
    [VS_strCodEmp, 'S']
  );
  ImgBase64Logo := IIF(Copy(ImgBase64Logo, 1, 4) = '/9j/', 'data:image/jpeg;base64,', 'data:image/png;base64,') + ImgBase64Logo;

  qryFr3 := fCriaQuery;
  try
    qryFr3.Close;
    qryFr3.SQL.Text := SQL_FR3;
    qryFr3.Open;

    // Imagem Titulo
    ImgBase64Titulo := ExtractFrxPictureBase64(qryFr3.FieldByName('LAY_ARQFR3').AsBytes, 'Picture2', 'Picture.PropData');
    // Titulo
    TxtTitulo := ExtractInfFrx(qryFr3.FieldByName('LAY_ARQFR3').AsBytes, 'Memo3', 'Text');
    // SubTitulo
    TxtSubTitulo := ExtractInfFrx(qryFr3.FieldByName('LAY_ARQFR3').AsBytes, 'Memo11', 'Text');
  finally
    FreeAndNil(qryFr3);
  end;

  // Monta os cards (3 por linha via CSS)
  CardsHtml := '';
  for i := 0 to High(ARecArquivos) do
  begin
    arrInfoArquivo :=
      ARecArquivos[i].Titulo
        .Replace(ExtractFileExt(ARecArquivos[i].Titulo), '')
        .Split(['_']);

    CardsHtml := CardsHtml +
      Format(
        '<a class="card" href="%s">' +
          '<div class="title">%s</div>' +
          '<div class="subtitle">%s</div>' +
          '<div class="access">Acessar →</div>' +
        '</a>',
        [
          ARecArquivos[i].Url,
          IfThen(Length(arrInfoArquivo) > 0, arrInfoArquivo[0], ''),
          IfThen(Length(arrInfoArquivo) > 1, arrInfoArquivo[1], '<br>')
        ]
      );
  end;

  Html :=
  '<!DOCTYPE html>' +
  '<html>' +
  '<head>' +
  '  <meta charset="utf-8">' +
  '  <style>' +
  '    html, body {' +
  '      height:29.7cm;' +  // A4
  '      font-family:DejaVu Sans,Arial,sans-serif;' +
  '      margin:0;' +
  '      padding:0;' +
  '      position:relative;' +  // necessário para footer absoluto
  '    }' +

  '    /* espaço inferior para o rodapé absoluto */' +
  '    body{padding-bottom:7.0cm;}' +  // ajuste conforme altura do footer

  '    .header{' +
  '      background:#0D2126;' +
  '      height:8.90cm;' +
  '      margin-bottom:0.8cm;' +
  '    }' +
  '    .header-inner{' +
  '      width:100%; height:100%; padding:1.3cm 1.8cm 2.23cm 1.8cm;' +
  '      box-sizing:border-box; display:table;' +
  '    }' +
  '    .header-content{display:table-row;height:100%;}' +
  '    .header-box-logo,.header-box-text,.header-gap{display:table-cell;vertical-align:middle;}' +
  '    .header-box-logo{width:4.3cm;height:4.65cm;background:#ffffff;border-radius:0.4cm;text-align:center;}' +
  '    .header-box-logo img{max-height:4cm;}' +
  '    .header-gap{width:0.65cm;}' +
  '    .header-box-text{width:11.8cm;height:4.65cm;background:#ffffff;border-radius:0.4cm;padding:0.8cm;box-sizing:border-box;}' +

  '    /* Tabela para título e subtítulo com imagem */' +
  '    .header-title-table{width:100%; border-collapse:collapse;}' +
  '    .header-title-table td{vertical-align:middle;}' +
  '    .header-title-table img{height:1.4cm; margin-right:0.45cm;}' +
  '    .header-title-text .header-title{font-size:22pt; font-weight:bold; color:#232323;}' +
  '    .header-title-text .header-subtitle{margin-top:0.3cm; font-size:12pt; color:#787878;}' +

  '    .section-title{' +
  '      font-size:18pt; font-weight:bold; color:#232323;' +
  '      padding:0 1.8cm; margin-top:0.9cm; margin-bottom:1.0cm;' +
  '    }' +

  '    .container {' +
  '      font-size:0; padding:0 1.8cm; box-sizing:border-box; text-align:left;' +
  '    }' +

  '    .card {' +
  '      display:inline-block; vertical-align:top; width:32%; margin-right:2%; margin-bottom:15px;' +
  '      box-sizing:border-box; border-radius:14px; border:1px solid #dfdfdf; padding:18px;' +
  '      text-decoration:none; color:#232323; font-size:12pt;' +
  '    }' +
  '    .card:nth-child(3n){margin-right:0;}' +
  '    .title{font-size:18pt;font-weight:bold;}' +
  '    .subtitle{margin-top:8px;font-size:18pt;font-weight:bold;}' +
  '    .access{margin-top:22px;color:#787878;font-size:12pt;}' +

  '    /* Rodapé absoluto */' +
  '    .footer {' +
  '      position:absolute; bottom:0; left:0; right:0;' +  // força o final da página
  '      padding:0 1.8cm 0.2cm 1.8cm; box-sizing:border-box; font-size:16pt;' +
  '    }' +
  '    .footer-line{border-top:1px solid #333333; margin-bottom:0.2cm;}' +
  '    .footer-table{width:100%; border-collapse:collapse;}' +
  '    .footer-table td{vertical-align:top;}' +

  '  </style>' +
  '</head>' +
  '<body>' +

  IfThen(
    not ImgBase64Logo.IsEmpty,
    '<div class="header">' +
      '<div class="header-inner">' +
        '<div class="header-content">' +
          '<div class="header-box-logo"><img src="' + ImgBase64Logo + '"></div>' +
          '<div class="header-gap"></div>' +
          '<div class="header-box-text">' +
            '<table class="header-title-table">' +
              '<tr>' +
                '<td><img src="' + ImgBase64Titulo + '"></td>' +
                '<td class="header-title-text">' +
                  '<div class="header-title">' + TxtTitulo + '</div>' +
                  '<div class="header-subtitle">' + TxtSubTitulo + '</div>' +
                '</td>' +
              '</tr>' +
            '</table>' +
          '</div>' +
        '</div>' +
      '</div>' +
    '</div>',
    ''
  ) +

  '<div class="section-title">Seus arquivos</div>' +

  '<div class="container">' + CardsHtml + '</div>' +

  '<div class="footer">' +
    '<div class="footer-line"></div>' +
    '<table class="footer-table">' +
      '<tr>' +
        '<td style="text-align:left; padding-right:1cm;">' +
          '<div>' + fCampoTabela('EMP_NOMEMP','CADEMP',['EMP_CODEMP'],[VS_strCodEmp]) + '</div>' +
          '<div>' + fFormataCpfCgc(fCampoTabela('EMP_C_G_C_','CADEMP',['EMP_CODEMP'],[VS_strCodEmp])) + '</div>' +
        '</td>' +
        '<td style="text-align:right; padding-left:1cm;">' +
          '<div>' + FormatDateTime('dd/MM/yyyy', fNow) + '</div>' +
          '<div>' + FormatDateTime('hh:mm:ss', fNow) + '</div>' +
        '</td>' +
      '</tr>' +
    '</table>' +
  '</div>' +

  '</body>' +
  '</html>';

  Result := fHtmlToPdf(Html, True, True);
end;

{$ELSE}

function fGerarPdfLinksWhatsappBase64(const ARecArquivos: TArray<TRecArquivosGatilhos>; AblnRetornarBase64: Boolean = True): string;
const
  SQL_FR3 =
    ' SELECT '+
    '   LAY_ARQFR3 '+
    ' FROM'+
    '   LAYFR3 '+
    ' WHERE '+
    '   LAY_NOMFOR = "TfrmAnexoLinksWhatsapp" AND '+
    '   LAY_NOMLAY = "frxPdfLinksWhatsapp" ';
var
  qryLayFr3: TUniQuery;
  Report: TfrxReport;
  StreamFR3: TStream;
  PDFStream: TMemoryStream;
  PDFExport: TfrxPDFExport;
  frxPicture: TfrxPictureView;
  Child: TfrxChild;
  Shape: TfrxShapeView;
  MemoTitle: TfrxMemoView;
  MemoSubTitle: TfrxMemoView;
  MemoAcessar: TfrxMemoView;
  Col, Row: Integer;
  LeftPos, TopPos: Double;
  BtnWidth, BtnHeight, Spacing, LeftTopTitle, LeftSubTitle, TopSubTitle, LeftAcessar, TopAcessar: Double;
  i: Integer;
  ImgBase64: String;
  arrInfoArquivo: TArray<String>;
  LDirExportar: String;
begin
  Result := '';

  qryLayFr3 := fCriaQuery;
  Report := TfrxReport.Create(nil);
  try
    qryLayFr3.Close;
    qryLayFr3.SQL.Text := SQL_FR3;
    qryLayFr3.Open;

    if qryLayFr3.IsEmpty then
      Exit;

    // ----- Carrega FR3 a partir do XML do banco -----
    StreamFR3 := qryLayFr3.CreateBlobStream(qryLayFr3.FieldByName('LAY_ARQFR3'), bmRead);
    try
      Report.LoadFromStream(StreamFR3);
    finally
      StreamFR3.Free;
    end;

    // ----- Carrega a logo do cliente -----
    ImgBase64 := fCampoTabela('EMP_IMGB64', 'EMPIMG', ['EMP_CODEMP', 'EMP_PRINCI'], [VS_strCodEmp, 'S']);
    frxPicture := Report.FindObject('Picture1') as TfrxPictureView;
    if (Assigned(frxPicture)) and (not fEmptyStr(ImgBase64)) then
      pImagemFromBase64(ImgBase64, frxPicture);

    // ----- Localiza o Child -----
    Child := Report.FindObject('Child1') as TfrxChild;
    if not Assigned(Child) then
      Exit;

    // ----- Config inicial dos botões -----
    BtnWidth := 215.43307575;
    BtnHeight := 117.16536409;

    LeftTopTitle := 21.32283465;

    LeftSubTitle := 21.32283465;
    TopSubTitle := 42.86614173;

    LeftAcessar := 21.32283465;
    TopAcessar := 80.0314985;

    Spacing := 12;

    // ----- Criação dos botões: 3 por linha -----
    for i := 0 to High(ARecArquivos) do
    begin
      Col := i mod 3;          // 0,1,2
      Row := i div 3;          // avança linha

      LeftPos := 58.58267717 + Col * (BtnWidth + Spacing);
      TopPos  := 7.55906 + Row * (BtnHeight + Spacing);

      // Ajusta altura total do Band
      if TopPos + BtnHeight > Child.Height then
        Child.Height := TopPos + BtnHeight;

      arrInfoArquivo := ARecArquivos[i].Titulo.Replace(ExtractFileExt(ARecArquivos[i].Titulo), '').Split(['_']);

      // ----- Shape arredondado -----
      Shape := TfrxShapeView.Create(Child);
      Shape.CreateUniqueName;
      Shape.Left := LeftPos;
      Shape.Top := TopPos;
      Shape.Width := BtnWidth;
      Shape.Height := BtnHeight;
      Shape.Shape := skRoundRectangle;
      Shape.Frame.Typ := [ftLeft, ftRight, ftTop, ftBottom];
      Shape.Frame.Color := $00DFDFDF;
      // HYPERLINK
      Shape.Hyperlink.Kind := hkURL;
      Shape.Hyperlink.Value := ARecArquivos[i].Url;


      // ----- Texto transparente sobre o botão -----
      MemoTitle := TfrxMemoView.Create(Child);
      MemoTitle.CreateUniqueName;
      MemoTitle.Left := Shape.Left + LeftTopTitle;
      MemoTitle.Top := Shape.Top + LeftTopTitle;
      MemoTitle.Width := Shape.Width - LeftTopTitle;
      MemoTitle.Height := Shape.Height;
      if Length(arrInfoArquivo) > 0 then
        MemoTitle.Text := arrInfoArquivo[0];
      MemoTitle.Font.Size := 14;
      MemoTitle.Font.Style := [fsBold];
      MemoTitle.Font.Color := $00232323;

      // ----- Texto transparente sobre o botão -----
      MemoSubTitle := TfrxMemoView.Create(Child);
      MemoSubTitle.CreateUniqueName;
      MemoSubTitle.Left := Shape.Left + LeftSubTitle;
      MemoSubTitle.Top := Shape.Top + TopSubTitle;
      MemoSubTitle.Width := Shape.Width - LeftSubTitle;
      MemoSubTitle.Height := Shape.Height;
      if Length(arrInfoArquivo) > 1 then
        MemoSubTitle.Text := arrInfoArquivo[1];
      MemoSubTitle.Font.Size := 14;
      MemoSubTitle.Font.Style := [fsBold];
      MemoSubTitle.Font.Color := $00232323;

      // ----- Texto transparente sobre o botão -----
      MemoAcessar := TfrxMemoView.Create(Child);
      MemoAcessar.CreateUniqueName;
      MemoAcessar.Left := Shape.Left + LeftAcessar;
      MemoAcessar.Top := Shape.Top + TopAcessar;
      MemoAcessar.Width := Shape.Width - LeftAcessar;
      MemoAcessar.Height := Shape.Height;
      MemoAcessar.Text := 'Acessar →';
      MemoAcessar.Font.Name := 'Arial Unicode MS';
      MemoAcessar.Font.Size := 12;
      MemoAcessar.Font.Color := $00787878;
    end;

    Report.Script.Variables['NOMEMP'] := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);
    Report.Script.Variables['C_G_C_'] := fFormataCpfCgc(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]), fSetaPais);

    // ----- PREPARAR E EXPORTAR PARA STREAM -----
    Report.PrepareReport;

    PDFStream := TMemoryStream.Create;
    PDFExport := TfrxPDFExport.Create(nil);
    try
      PDFExport.ShowDialog := False;
      PDFExport.ShowProgress := False;
      PDFExport.OpenAfterExport := False;
      PDFExport.Background := True;
      PDFExport.PrintOptimized := True;

      if not AblnRetornarBase64 then
      begin
        LDirExportar := GetCurrentDir + {$IFDEF LINUX}'/'{$ELSE}'\'{$ENDIF LINUX} + 'temp' + {$IFDEF LINUX}'/'{$ELSE}'\'{$ENDIF LINUX};;
        ForceDirectories(LDirExportar);

        PDFExport.FileName := LDirExportar + 'LinksWhatsapp.pdf';
        Result := PDFExport.FileName;
      end
      else
        PDFExport.Stream := PDFStream;

      Report.Export(PDFExport);

      if AblnRetornarBase64 then
      begin
        // Converte stream Base64
        PDFStream.Position := 0;
        Result := TNetEncoding.Base64.EncodeBytesToString(PDFStream.Memory, PDFStream.Size);
      end;

    finally
      PDFStream.Free;
      PDFExport.Free;
    end;

  finally
    FreeAndNil(Report);
    FreeAndNil(qryLayFr3);
  end;
end;

{$ENDIF LINUX}

end.
