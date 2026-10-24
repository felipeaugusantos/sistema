{******************************************************************************}
{* QUADRO DE LICENCAS - VIEW DA VERSAO NOVA (FMX)                             *}
{*                                                                            *}
{* Mesmo desenho da versao classica, desenhado com o Canvas do FireMonkey.     *}
{* Os dados chegam prontos por IQuadroLicencas, que o host (TfrmPrincipal)     *}
{* monta a partir de untQuadroLicencasDados - a mesma fonte que alimenta a     *}
{* versao classica. Aqui so ha desenho.                                       *}
{*                                                                            *}
{* Diferencas em relacao a view VCL, por conta do framework:                   *}
{*   - a borda e o Stroke do TRectangle, sem o truque dos dois paineis         *}
{*   - FillText nao faz reticencias: o nome e truncado medindo com TextWidth   *}
{*   - a cor e TAlphaColor ($AARRGGBB), nao TColor ($00BBGGRR)                 *}
{*                                                                            *}
{* Fica flutuante na inferior direita do layout que recebe como pai. O quadro  *}
{* pinta o proprio fundo: a tela nova tambem usa a cor de identificacao da     *}
{* empresa, entao a legibilidade nao pode depender do cadastro.                *}
{******************************************************************************}
unit Principal.View.FMXQuadroLicencas;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes,
  FMX.Types, FMX.Controls, FMX.Objects, FMX.Graphics,
  Principal.View.Interfaces;

Type
  TQuadroLicencasFMX = Class(TObject)
  Private
    FctrPai   : TControl;
    FrecQuadro: TRectangle;
    FpbxQuadro: TPaintBox;
    FarrItens : TArray<ILicencaProduto>;
    FintAcima : Integer;

    function  fCorFaixa(Const AintFaixa: Integer): TAlphaColor;
    function  fDataBaseResumo: TDateTime;
    function  fTruncar(ACanvas: TCanvas; Const AstrTexto: String;
                       Const AfltLargura: Single): String;
    procedure pCriarControles;
    procedure pDestruirControles;
    procedure pPosicionar;
    procedure pMontarHint;
    procedure pPintarQuadro(Sender: TObject; ACanvas: TCanvas);
    procedure pDesenharLinha(ACanvas: TCanvas; Const AfltTopo: Single;
                             Const AobjLic: ILicencaProduto);
  Public
    Constructor Create(ActrPai: TControl);
    Destructor  Destroy; Override;

    { Idempotente: pode ser chamado a cada abertura ou troca de empresa. }
    procedure pAtualizar(Const AobjDados: IQuadroLicencas);

    { Verdadeiro quando o quadro esta na tela. O host usa para esconder o
      lblSaudacao, que tem Align Client com AutoSize e transborda a barra
      inferior por cima do quadro. }
    function fVisivel: Boolean;
  End;

implementation

Const
  { mesmas medidas da view classica }
  LAR_QUADRO    = 380;
  PAD_HOR       = 9;
  PAD_VER       = 5;
  ALT_CABECALHO = 15;
  ALT_FILETE    = 2;
  ALT_LINHA     = 20;
  ALT_MEDIDOR   = 8;
  COL_TITULO    = 64;   { rotulo LICENCAS, no cabecalho }
  COL_DATA      = 54;   { data-base, no cabecalho, ao lado do rotulo }
  COL_NOME      = 150;  { nome do produto, na linha }
  COL_NUMERO    = 68;
  COL_VAO       = 6;
  MIN_MEDIDOR   = 40;
  MRG_DIREITA   = 16;
  MRG_INFERIOR  = 16;

  PRC_CORTE = 0.82;

  { A tela nova nao tem tema escuro hoje; se ganhar, este bloco vira par como }
  { na view classica.                                                        }
  COR_SUPERFICIE : TAlphaColor = $FFF4F6F9;
  COR_BORDA      : TAlphaColor = $FFC7D0DB;
  COR_TEXTO      : TAlphaColor = $FF141A22;
  COR_SECUNDARIA : TAlphaColor = $FF5F6B7A;
  COR_TRILHO     : TAlphaColor = $FFCFD8E3;
  COR_DENTRO     : TAlphaColor = $FF1F5C99;
  COR_LIMITE     : TAlphaColor = $FFB87309;
  COR_ACIMA      : TAlphaColor = $FFA63528;
  COR_RISCO      : TAlphaColor = $FF6B7684;

  FNT_TEXTO  = 'Segoe UI';
  FNT_NUMERO = 'Consolas';

  FAIXA_ACIMA      = 0;
  FAIXA_NO_LIMITE  = 1;
  FAIXA_DENTRO     = 2;

{*******************************************}
{* DATA NULA NAO VIRA 30/12/1899           *}
{*******************************************}
function fDataTexto(Const AdtaData: TDateTime; Const AstrMascara: String): String;
begin
  If AdtaData > 0 Then
    Result := FormatDateTime(AstrMascara, AdtaData)
  Else
    Result := '-';
end;

{*******************************************}
{* ESCREVE TEXTO NO CANVAS DO FMX          *}
{*******************************************}
procedure pTexto(ACanvas: TCanvas; Const ARect: TRectF; Const AstrTexto: String;
                 Const AcorTexto: TAlphaColor; Const AstrFonte: String;
                 Const AblnNegrito: Boolean; Const AaliHor: TTextAlign);
begin
  If AstrTexto = '' Then
    Exit;

  ACanvas.Font.Family := AstrFonte;
  ACanvas.Font.Size   := 11;

  If AblnNegrito Then
    ACanvas.Font.Style := [TFontStyle.fsBold]
  Else
    ACanvas.Font.Style := [];

  ACanvas.Fill.Kind  := TBrushKind.Solid;
  ACanvas.Fill.Color := AcorTexto;

  ACanvas.FillText(ARect, AstrTexto, False, 1, [], AaliHor, TTextAlign.Center);
end;

{*******************************************}
{* PINTA UM RETANGULO CHEIO                *}
{*******************************************}
procedure pPreencher(ACanvas: TCanvas; Const ARect: TRectF; Const Acor: TAlphaColor);
begin
  ACanvas.Fill.Kind  := TBrushKind.Solid;
  ACanvas.Fill.Color := Acor;

  ACanvas.FillRect(ARect, 0, 0, [], 1);
end;

{ TQuadroLicencasFMX }

Constructor TQuadroLicencasFMX.Create(ActrPai: TControl);
begin
  Inherited Create;

  FctrPai   := ActrPai;
  FintAcima := 0;

  SetLength(FarrItens, 0);
end;

Destructor TQuadroLicencasFMX.Destroy;
begin
  pDestruirControles;

  Inherited;
end;

function TQuadroLicencasFMX.fCorFaixa(Const AintFaixa: Integer): TAlphaColor;
begin
  Case AintFaixa Of
    FAIXA_ACIMA    : Result := COR_ACIMA;
    FAIXA_NO_LIMITE: Result := COR_LIMITE;
    FAIXA_DENTRO   : Result := COR_DENTRO;
  Else
    { sem limite nao existe 'acima do limite': fica na cor de texto }
    Result := COR_TEXTO;
  End;
end;

{*******************************************}
{* A DATA DO CABECALHO E A MAIS RECENTE    *}
{* ENTRE OS PRODUTOS. A DE CADA UM SEGUE   *}
{* NO HINT, QUE E ONDE APARECE UM COLETOR  *}
{* PARADO                                  *}
{*******************************************}
function TQuadroLicencasFMX.fDataBaseResumo: TDateTime;
  Var
    intI: Integer;
begin
  Result := 0;

  For intI := 0 To High(FarrItens) Do
    If FarrItens[intI].DataBase > Result Then
      Result := FarrItens[intI].DataBase;
end;

{*******************************************}
{* FILLTEXT DO FMX NAO FAZ RETICENCIAS:    *}
{* CORTA MEDINDO E ACRESCENTA OS PONTOS    *}
{*******************************************}
function TQuadroLicencasFMX.fTruncar(ACanvas: TCanvas; Const AstrTexto: String;
                                     Const AfltLargura: Single): String;
  Var
    strAux: String;
begin
  Result := AstrTexto;

  If ACanvas.TextWidth(Result) <= AfltLargura Then
    Exit;

  strAux := AstrTexto;

  While (strAux <> '') And (ACanvas.TextWidth(strAux + '...') > AfltLargura) Do
    strAux := Copy(strAux, 1, Length(strAux) - 1);

  If strAux = '' Then
    Result := ''
  Else
    Result := strAux + '...';
end;

procedure TQuadroLicencasFMX.pCriarControles;
begin
  If Assigned(FrecQuadro) Then
    Exit;

  If Not Assigned(FctrPai) Then
    Exit;

  { no FMX a borda e o Stroke do proprio retangulo }
  FrecQuadro := TRectangle.Create(FctrPai);
  FrecQuadro.Name          := 'recLicencas';
  FrecQuadro.Parent        := FctrPai;
  FrecQuadro.Align         := TAlignLayout.None;
  FrecQuadro.Anchors       := [TAnchorKind.akRight, TAnchorKind.akBottom];
  FrecQuadro.XRadius       := 0;
  FrecQuadro.YRadius       := 0;
  FrecQuadro.Fill.Kind     := TBrushKind.Solid;
  FrecQuadro.Fill.Color    := COR_SUPERFICIE;
  FrecQuadro.Stroke.Kind   := TBrushKind.Solid;
  FrecQuadro.Stroke.Color  := COR_BORDA;
  FrecQuadro.Stroke.Thickness := 1;
  FrecQuadro.Width         := LAR_QUADRO;
  FrecQuadro.ShowHint      := True;
  FrecQuadro.HitTest       := True;

  FpbxQuadro := TPaintBox.Create(FrecQuadro);
  FpbxQuadro.Name     := 'pbxLicencas';
  FpbxQuadro.Parent   := FrecQuadro;
  FpbxQuadro.Align    := TAlignLayout.Client;
  FpbxQuadro.HitTest  := False;
  FpbxQuadro.OnPaint  := pPintarQuadro;
end;

procedure TQuadroLicencasFMX.pDestruirControles;
begin
  { FpbxQuadro tem FrecQuadro como Owner: cai junto }
  FpbxQuadro := Nil;

  If Assigned(FrecQuadro) Then
    FreeAndNil(FrecQuadro);
end;

{*******************************************}
{* ALTURA ACOMPANHA O NUMERO DE LINHAS.    *}
{* FICA FLUTUANTE NA INFERIOR DIREITA      *}
{*******************************************}
procedure TQuadroLicencasFMX.pPosicionar;
  Var
    fltAltura: Single;
begin
  If Not Assigned(FrecQuadro) Then
    Exit;

  { todas as linhas: a lista nao e truncada, independente de quantos produtos }
  fltAltura := (PAD_VER * 2) + ALT_CABECALHO + ALT_FILETE +
               (ALT_LINHA * Length(FarrItens));

  FrecQuadro.Height     := fltAltura;
  FrecQuadro.Position.X := FctrPai.Width  - LAR_QUADRO - MRG_DIREITA;
  FrecQuadro.Position.Y := FctrPai.Height - fltAltura  - MRG_INFERIOR;
end;

procedure TQuadroLicencasFMX.pMontarHint;
  Var
    intI      : Integer;
    strHint   : String;
    strDetalhe: String;
begin
  If Not Assigned(FrecQuadro) Then
    Exit;

  strHint := 'Licencas - operadores distintos que acessaram na data-base';

  For intI := 0 To High(FarrItens) Do
  Begin
    If FarrItens[intI].Contratadas > 0 Then
      strDetalhe := IntToStr(FarrItens[intI].Utilizadas) + ' de ' +
                    IntToStr(FarrItens[intI].Contratadas) + ' contratadas'
    Else
      strDetalhe := IntToStr(FarrItens[intI].Utilizadas) +
                    ' em uso, sem limite contratado';

    strHint := strHint + sLineBreak +
               FarrItens[intI].Produto + ': ' + strDetalhe +
               '  (base ' + fDataTexto(FarrItens[intI].DataBase, 'dd/mm/yyyy') + ')';
  End;

  FrecQuadro.Hint := strHint;
end;

procedure TQuadroLicencasFMX.pPintarQuadro(Sender: TObject; ACanvas: TCanvas);
  Var
    intI     : Integer;
    fltTopo  : Single;
    fltDir   : Single;
    strStatus: String;
    corStatus: TAlphaColor;
begin
  If Not Assigned(FpbxQuadro) Then
    Exit;

  fltDir := FpbxQuadro.Width - PAD_HOR;

  { cabecalho: titulo a esquerda }
  pTexto(ACanvas, RectF(PAD_HOR, PAD_VER, PAD_HOR + COL_TITULO, PAD_VER + ALT_CABECALHO),
         'LICENCAS', COR_TEXTO, FNT_TEXTO, True, TTextAlign.Leading);

  { data-base do resumo, ao lado do rotulo }
  pTexto(ACanvas, RectF(PAD_HOR + COL_TITULO + COL_VAO, PAD_VER,
                        PAD_HOR + COL_TITULO + COL_VAO + COL_DATA,
                        PAD_VER + ALT_CABECALHO),
         fDataTexto(fDataBaseResumo, 'dd/mm/yy'),
         COR_SECUNDARIA, FNT_NUMERO, False, TTextAlign.Leading);

  { cabecalho: estado a direita }
  If FintAcima > 0 Then
  Begin
    corStatus := COR_ACIMA;

    If FintAcima = 1 Then
      strStatus := '1 acima do limite'
    Else
      strStatus := IntToStr(FintAcima) + ' acima do limite';
  End
  Else
  Begin
    corStatus := COR_SECUNDARIA;

    If Length(FarrItens) = 1 Then
      strStatus := '1 produto'
    Else
      strStatus := IntToStr(Length(FarrItens)) + ' produtos';
  End;

  pTexto(ACanvas, RectF(fltDir - 170, PAD_VER, fltDir, PAD_VER + ALT_CABECALHO),
         strStatus, corStatus, FNT_TEXTO, FintAcima > 0, TTextAlign.Trailing);

  { filete sob o cabecalho }
  pPreencher(ACanvas, RectF(PAD_HOR, PAD_VER + ALT_CABECALHO + 1,
                            fltDir,  PAD_VER + ALT_CABECALHO + 2), COR_BORDA);

  { todas as linhas: a lista nao e truncada, independente de quantos produtos }
  fltTopo := PAD_VER + ALT_CABECALHO + ALT_FILETE;

  For intI := 0 To High(FarrItens) Do
  Begin
    pDesenharLinha(ACanvas, fltTopo, FarrItens[intI]);
    fltTopo := fltTopo + ALT_LINHA;
  End;
end;

procedure TQuadroLicencasFMX.pDesenharLinha(ACanvas: TCanvas; Const AfltTopo: Single;
                                            Const AobjLic: ILicencaProduto);
  Var
    fltDir    : Single;
    fltXNome  : Single;
    fltXMeio  : Single;
    fltXNumero: Single;
    fltLarMeio: Single;
    fltTopMed : Single;
    fltLarUso : Single;
    fltXCorte : Single;
    strNumero : String;
begin
  fltDir     := FpbxQuadro.Width - PAD_HOR;
  fltXNome   := PAD_HOR;
  fltXMeio   := fltXNome + COL_NOME + COL_VAO;
  fltXNumero := fltDir - COL_NUMERO;
  fltLarMeio := fltXNumero - COL_VAO - fltXMeio;

  If fltLarMeio < MIN_MEDIDOR Then
    fltLarMeio := MIN_MEDIDOR;

  { ID_PRODUTO como esta na tabela; o nome completo fica no hint }
  ACanvas.Font.Family := FNT_TEXTO;
  ACanvas.Font.Size   := 11;
  ACanvas.Font.Style  := [];

  pTexto(ACanvas, RectF(fltXNome, AfltTopo, fltXNome + COL_NOME, AfltTopo + ALT_LINHA),
         fTruncar(ACanvas, AobjLic.Produto, COL_NOME),
         COR_TEXTO, FNT_TEXTO, False, TTextAlign.Leading);


  If AobjLic.Contratadas > 0 Then
  Begin
    fltTopMed := AfltTopo + ((ALT_LINHA - ALT_MEDIDOR) / 2);

    pPreencher(ACanvas, RectF(fltXMeio, fltTopMed,
                              fltXMeio + fltLarMeio, fltTopMed + ALT_MEDIDOR),
               COR_TRILHO);

    fltLarUso := fltLarMeio * PRC_CORTE * AobjLic.PercentualUso;

    If fltLarUso > fltLarMeio Then
      fltLarUso := fltLarMeio;

    { uso maior que zero nunca desaparece por arredondamento }
    If (fltLarUso < 1) And (AobjLic.Utilizadas > 0) Then
      fltLarUso := 1;

    If fltLarUso > 0 Then
      pPreencher(ACanvas, RectF(fltXMeio, fltTopMed,
                                fltXMeio + fltLarUso, fltTopMed + ALT_MEDIDOR),
                 fCorFaixa(AobjLic.Faixa));

    { vao de 2px na cor do fundo mais risco de 1px acima do trilho: a linha de }
    { corte continua visivel quando o preenchimento passa por ela              }
    fltXCorte := fltXMeio + (fltLarMeio * PRC_CORTE);

    pPreencher(ACanvas, RectF(fltXCorte, fltTopMed,
                              fltXCorte + 2, fltTopMed + ALT_MEDIDOR), COR_SUPERFICIE);

    pPreencher(ACanvas, RectF(fltXCorte, fltTopMed - 4,
                              fltXCorte + 1, fltTopMed), COR_RISCO);

    strNumero := IntToStr(AobjLic.Utilizadas) + '/' + IntToStr(AobjLic.Contratadas);
  End
  Else
    { sem limite contratado nao ha proporcao para desenhar: a coluna do meio
      fica vazia, so nome e quantidade }
    strNumero := IntToStr(AobjLic.Utilizadas);

  pTexto(ACanvas, RectF(fltXNumero, AfltTopo, fltDir, AfltTopo + ALT_LINHA),
         strNumero, fCorFaixa(AobjLic.Faixa), FNT_NUMERO, True, TTextAlign.Trailing);
end;

{*******************************************}
{* PONTO DE ENTRADA. AS TRES CONDICOES DO  *}
{* REQUISITO JA VIERAM RESOLVIDAS DO HOST  *}
{*******************************************}
function TQuadroLicencasFMX.fVisivel: Boolean;
begin
  Result := Assigned(FrecQuadro);
end;

procedure TQuadroLicencasFMX.pAtualizar(Const AobjDados: IQuadroLicencas);
begin
  If (Not Assigned(AobjDados)) Or (Not AobjDados.Visivel) Then
  Begin
    pDestruirControles;
    Exit;
  End;

  FarrItens := AobjDados.Itens;
  FintAcima := AobjDados.QtdAcimaDoLimite;

  If Length(FarrItens) = 0 Then
  Begin
    pDestruirControles;
    Exit;
  End;

  pCriarControles;

  If Not Assigned(FrecQuadro) Then
    Exit;

  pMontarHint;
  pPosicionar;

  FpbxQuadro.Repaint;
end;

end.
