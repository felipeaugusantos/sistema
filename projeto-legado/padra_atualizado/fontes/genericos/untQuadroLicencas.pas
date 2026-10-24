{******************************************************************************}
{* QUADRO DE LICENCAS - VIEW DA VERSAO CLASSICA (VCL)                         *}
{*                                                                            *}
{* Desenha, no rodape esquerdo da tela principal classica, a quantidade de     *}
{* licencas contratadas e utilizadas dos produtos controlados por licenca.     *}
{*                                                                            *}
{* Dados, regras, faixa de uso e ordem vem de untQuadroLicencasDados - a mesma *}
{* fonte que alimenta a versao nova (FMX). Aqui so ha desenho.                 *}
{*                                                                            *}
{* Por linha, o tipo sai de QTD_LIC_CONTRATADAS:                              *}
{*   > 0  o cliente tem limite contratado e pode ultrapassar: medidor com a    *}
{*        linha de corte marcando o contratado                                 *}
{*   <= 0 o cliente nao tem limite: sem grafico, so nome, data e utilizadas    *}
{*                                                                            *}
{* Os controles sao criados em tempo de execucao de proposito: o quadro e      *}
{* excecao (so o master ve) e o numero de linhas vem do banco.                 *}
{******************************************************************************}
unit untQuadroLicencas;

interface

uses
  Windows, Types, Classes, Controls, ExtCtrls, Graphics, SysUtils,
  untQuadroLicencasDados;

Type
  TQuadroLicencas = Class(TObject)
  Private
    FpnlPai      : TWinControl;
    FpnlBorda    : TPanel;
    FpnlQuadro   : TPanel;
    FpbxQuadro   : TPaintBox;
    FarrLicencas : TarrLicencas;
    FintAcima    : Integer;
    FblnTemaClaro: Boolean;

    function  fCorSuperficie: TColor;
    function  fCorBorda: TColor;
    function  fCorTexto: TColor;
    function  fCorSecundaria: TColor;
    function  fCorTrilho: TColor;
    function  fCorRisco: TColor;
    function  fCorFaixa(Const AintFaixa: Integer): TColor;

    function  fDataBaseResumo: TDate;

    procedure pCriarControles;
    procedure pDestruirControles;
    procedure pPosicionar;
    procedure pMontarHint;
    procedure pPintarQuadro(Sender: TObject);
    procedure pDesenharLinha(ACanvas: TCanvas; Const AintTopo: Integer;
                             Const AdtoLic: TdtoLicenca);
  Public
    Constructor Create(ApnlPai: TWinControl);
    Destructor  Destroy; Override;

    { Idempotente: pode ser chamado a cada troca de operador ou de empresa.      }
    { AblnTemaClaro vem do form, porque IsLightTheme e metodo de TfrmPrincipal.  }
    procedure pAtualizar(Const AstrCodOpe: String; Const AblnTemaClaro: Boolean);
  End;

implementation

Const
  { medidas do quadro, em pixels }
  LAR_QUADRO    = 380;
  LAR_BORDA     = 1;
  PAD_HOR       = 9;
  PAD_VER       = 5;
  ALT_CABECALHO = 15;
  ALT_FILETE    = 2;
  ALT_LINHA     = 20;
  ALT_MEDIDOR   = 8;
  MRG_ESQUERDA  = 16;
  MRG_INFERIOR  = 16;
  COL_TITULO    = 64;   { rotulo LICENCAS, no cabecalho }
  COL_DATA      = 54;   { data-base, no cabecalho, ao lado do rotulo }
  COL_NOME      = 150;  { nome do produto, na linha }
  COL_NUMERO    = 68;
  COL_VAO       = 6;
  MIN_MEDIDOR   = 40;
  LAR_STATUS    = 170;

  { Onde a linha de corte fica dentro do trilho. O espaco que sobra a direita }
  { existe para o estouro ter para onde ir e ser visto - medidor que satura   }
  { em 100% esconde justamente o caso que o quadro existe para mostrar.       }
  PRC_CORTE = 0.82;

  { tema claro }
  COR_CLA_SUPERFICIE = $00F9F6F4;
  COR_CLA_BORDA      = $00DBD0C7;
  COR_CLA_TEXTO      = $00221A14;
  COR_CLA_SECUNDARIA = $007A6B5F;
  COR_CLA_TRILHO     = $00E3D8CF;
  COR_CLA_DENTRO     = $00995C1F;
  COR_CLA_LIMITE     = $000973B8;
  COR_CLA_ACIMA      = $002835A6;
  COR_CLA_RISCO      = $0084766B;

  { tema escuro - reescalado, nao e inversao do claro }
  COR_ESC_SUPERFICIE = $00302823;
  COR_ESC_BORDA      = $004D4139;
  COR_ESC_TEXTO      = $00F1EBE6;
  COR_ESC_SECUNDARIA = $00AFA093;
  COR_ESC_TRILHO     = $00453B33;
  COR_ESC_DENTRO     = $00D9904A;
  COR_ESC_LIMITE     = $00008DB0;
  COR_ESC_ACIMA      = $00463ED3;
  COR_ESC_RISCO      = $0094877C;

  FNT_TEXTO  = 'Segoe UI';
  FNT_NUMERO = 'Consolas';

{*******************************************}
{* PINTA UM RETANGULO CHEIO                *}
{*******************************************}
procedure pPreencher(ACanvas: TCanvas; Const ARect: TRect; Const Acor: TColor);
begin
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := Acor;

  ACanvas.FillRect(ARect);
end;

{*******************************************}
{* ESCREVE TEXTO NO CANVAS, COM RETICENCIAS*}
{* QUANDO NAO COUBER NO RETANGULO          *}
{*******************************************}
procedure pTexto(ACanvas: TCanvas; ARect: TRect; Const AstrTexto: String;
                 Const AintFlags: Cardinal);
  Var
    rctAux: TRect;
begin
  If AstrTexto = '' Then
    Exit;

  { bsClear em toda escrita: o TCanvas da VCL refaz o bk mode do DC quando o
    Brush muda, entao um SetBkMode chamado uma vez nao sobrevive ao desenho do
    medidor - e o texto sairia com o fundo na cor do brush corrente. }
  ACanvas.Brush.Style := bsClear;

  rctAux := ARect;

  DrawText(ACanvas.Handle, PChar(AstrTexto), Length(AstrTexto), rctAux,
           AintFlags Or DT_SINGLELINE Or DT_VCENTER Or DT_NOPREFIX);
end;

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

{ TQuadroLicencas }

Constructor TQuadroLicencas.Create(ApnlPai: TWinControl);
begin
  Inherited Create;

  FpnlPai       := ApnlPai;
  FblnTemaClaro := True;
  FintAcima     := 0;

  SetLength(FarrLicencas, 0);
end;

Destructor TQuadroLicencas.Destroy;
begin
  pDestruirControles;

  Inherited;
end;

function TQuadroLicencas.fCorSuperficie: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_SUPERFICIE
  Else
    Result := COR_ESC_SUPERFICIE;
end;

function TQuadroLicencas.fCorBorda: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_BORDA
  Else
    Result := COR_ESC_BORDA;
end;

function TQuadroLicencas.fCorTexto: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_TEXTO
  Else
    Result := COR_ESC_TEXTO;
end;

function TQuadroLicencas.fCorSecundaria: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_SECUNDARIA
  Else
    Result := COR_ESC_SECUNDARIA;
end;

function TQuadroLicencas.fCorTrilho: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_TRILHO
  Else
    Result := COR_ESC_TRILHO;
end;

function TQuadroLicencas.fCorRisco: TColor;
begin
  If FblnTemaClaro Then
    Result := COR_CLA_RISCO
  Else
    Result := COR_ESC_RISCO;
end;

{*******************************************}
{* COR DA FAIXA DE USO. SEM LIMITE NAO TEM *}
{* 'ACIMA DO LIMITE', ENTAO FICA NO TEXTO  *}
{*******************************************}
function TQuadroLicencas.fCorFaixa(Const AintFaixa: Integer): TColor;
begin
  Case AintFaixa Of
    FAIXA_ACIMA:
      If FblnTemaClaro Then
        Result := COR_CLA_ACIMA
      Else
        Result := COR_ESC_ACIMA;
    FAIXA_NO_LIMITE:
      If FblnTemaClaro Then
        Result := COR_CLA_LIMITE
      Else
        Result := COR_ESC_LIMITE;
    FAIXA_DENTRO:
      If FblnTemaClaro Then
        Result := COR_CLA_DENTRO
      Else
        Result := COR_ESC_DENTRO;
  Else
    Result := fCorTexto;
  End;
end;

{*******************************************}
{* A DATA DO CABECALHO E A MAIS RECENTE    *}
{* ENTRE OS PRODUTOS. A DE CADA UM SEGUE   *}
{* NO HINT, QUE E ONDE APARECE UM COLETOR  *}
{* PARADO                                  *}
{*******************************************}
function TQuadroLicencas.fDataBaseResumo: TDate;
  Var
    intI: Integer;
begin
  Result := 0;

  For intI := 0 To High(FarrLicencas) Do
    If FarrLicencas[intI].dtaDataBase > Result Then
      Result := FarrLicencas[intI].dtaDataBase;
end;

{*******************************************}
{* CRIA OS TRES CONTROLES. IDEMPOTENTE     *}
{*******************************************}
procedure TQuadroLicencas.pCriarControles;
begin
  If Assigned(FpnlBorda) Then
    Exit;

  If Not Assigned(FpnlPai) Then
    Exit;

  { painel externo com a cor da borda; o interno com Margins 1 faz o fio de 1px }
  FpnlBorda := TPanel.Create(FpnlPai);
  FpnlBorda.Name             := 'pnlLicencasBorda';
  FpnlBorda.Caption          := '';
  FpnlBorda.BevelInner       := bvNone;
  FpnlBorda.BevelOuter       := bvNone;
  FpnlBorda.ParentBackground := False;
  FpnlBorda.ParentColor      := False;
  FpnlBorda.Color            := fCorBorda;
  FpnlBorda.Width            := LAR_QUADRO + (LAR_BORDA * 2);

  { flutuante na inferior esquerda do pai. Align imporia a altura do pai, e com
    a lista completa o quadro tem de poder crescer para cima. }
  FpnlBorda.Parent           := FpnlPai;
  FpnlBorda.Align            := alNone;
  FpnlBorda.Anchors          := [akLeft, akBottom];

  { pnlFundo.Color recebe fRetCorEmpresa e pode ser qualquer cor cadastrada:   }
  { o quadro pinta o proprio fundo para nao depender do cadastro da empresa.   }
  FpnlQuadro := TPanel.Create(FpnlBorda);
  FpnlQuadro.Name             := 'pnlLicencas';
  FpnlQuadro.Caption          := '';
  FpnlQuadro.BevelInner       := bvNone;
  FpnlQuadro.BevelOuter       := bvNone;
  FpnlQuadro.ParentBackground := False;
  FpnlQuadro.ParentColor      := False;
  FpnlQuadro.Color            := fCorSuperficie;
  FpnlQuadro.AlignWithMargins := True;
  FpnlQuadro.Margins.Left     := LAR_BORDA;
  FpnlQuadro.Margins.Top      := LAR_BORDA;
  FpnlQuadro.Margins.Right    := LAR_BORDA;
  FpnlQuadro.Margins.Bottom   := LAR_BORDA;
  FpnlQuadro.ShowHint         := True;
  FpnlQuadro.Parent           := FpnlBorda;
  FpnlQuadro.Align            := alClient;

  { uma TPaintBox desenha cabecalho, linhas e rodape: sao dois tipos de linha, }
  { o numero delas vem do banco, e nem TcxProgressBar nem TdxGauge fazem a     }
  { linha de corte                                                            }
  FpbxQuadro := TPaintBox.Create(FpnlQuadro);
  FpbxQuadro.Name     := 'pbxLicencas';
  FpbxQuadro.ShowHint := True;
  FpbxQuadro.OnPaint  := pPintarQuadro;
  FpbxQuadro.Parent   := FpnlQuadro;
  FpbxQuadro.Align    := alClient;
end;

procedure TQuadroLicencas.pDestruirControles;
begin
  { FpnlQuadro e FpbxQuadro tem FpnlBorda como Owner: cai tudo junto }
  FpbxQuadro := Nil;
  FpnlQuadro := Nil;

  If Assigned(FpnlBorda) Then
    FreeAndNil(FpnlBorda);
end;

{*******************************************}
{* ALTURA ACOMPANHA O NUMERO DE LINHAS.    *}
{* FLUTUA NA INFERIOR ESQUERDA DO PAI E    *}
{* CRESCE PARA CIMA - A LISTA NAO E CORTADA*}
{*******************************************}
procedure TQuadroLicencas.pPosicionar;
  Var
    intLargura: Integer;
    intAltura : Integer;
begin
  If Not Assigned(FpnlBorda) Then
    Exit;

  intLargura := LAR_QUADRO + (LAR_BORDA * 2);

  intAltura := (PAD_VER * 2) + ALT_CABECALHO + ALT_FILETE +
               (ALT_LINHA * Length(FarrLicencas)) + (LAR_BORDA * 2);

  FpnlBorda.SetBounds(MRG_ESQUERDA,
                      FpnlPai.ClientHeight - intAltura - MRG_INFERIOR,
                      intLargura, intAltura);
end;

{*******************************************}
{* O HINT LISTA TODOS OS PRODUTOS, INCLU-  *}
{* SIVE OS QUE NAO CABEM NAS TRES LINHAS   *}
{*******************************************}
procedure TQuadroLicencas.pMontarHint;
  Var
    intI      : Integer;
    strHint   : String;
    strDetalhe: String;
begin
  If Not Assigned(FpnlQuadro) Then
    Exit;

  strHint := 'Licencas - operadores distintos que acessaram na data-base';

  For intI := 0 To High(FarrLicencas) Do
  Begin
    If FarrLicencas[intI].intContratadas > 0 Then
      strDetalhe := IntToStr(FarrLicencas[intI].intUtilizadas) + ' de ' +
                    IntToStr(FarrLicencas[intI].intContratadas) + ' contratadas'
    Else
      strDetalhe := IntToStr(FarrLicencas[intI].intUtilizadas) +
                    ' em uso, sem limite contratado';

    strHint := strHint + sLineBreak +
               FarrLicencas[intI].strIdProduto + ': ' + strDetalhe +
               '  (base ' + fDataTexto(FarrLicencas[intI].dtaDataBase, 'dd/mm/yyyy') +
               ', calculado em ' +
               fDataTexto(FarrLicencas[intI].dtaUltAtu, 'dd/mm/yyyy hh:nn') + ')';
  End;

  FpnlQuadro.Hint := strHint;

  If Assigned(FpbxQuadro) Then
    FpbxQuadro.Hint := strHint;
end;

{*******************************************}
{* DESENHA O QUADRO INTEIRO                *}
{*******************************************}
procedure TQuadroLicencas.pPintarQuadro(Sender: TObject);
  Var
    ACanvas  : TCanvas;
    intI     : Integer;
    intTopo  : Integer;
    intDir   : Integer;
    strStatus: String;
begin
  If Not Assigned(FpbxQuadro) Then
    Exit;

  ACanvas := FpbxQuadro.Canvas;

  pPreencher(ACanvas, FpbxQuadro.ClientRect, fCorSuperficie);

  intDir := FpbxQuadro.ClientWidth - PAD_HOR;

  { cabecalho: titulo a esquerda }
  ACanvas.Font.Name  := FNT_TEXTO;
  ACanvas.Font.Size  := 8;
  ACanvas.Font.Style := [fsBold];
  ACanvas.Font.Color := fCorTexto;

  pTexto(ACanvas, Rect(PAD_HOR, PAD_VER, PAD_HOR + COL_TITULO, PAD_VER + ALT_CABECALHO),
         'LICENCAS', DT_LEFT);

  { data-base do resumo, ao lado do rotulo }
  ACanvas.Font.Name  := FNT_NUMERO;
  ACanvas.Font.Style := [];
  ACanvas.Font.Color := fCorSecundaria;

  pTexto(ACanvas, Rect(PAD_HOR + COL_TITULO + COL_VAO, PAD_VER,
                       PAD_HOR + COL_TITULO + COL_VAO + COL_DATA,
                       PAD_VER + ALT_CABECALHO),
         fDataTexto(fDataBaseResumo, 'dd/mm/yy'), DT_LEFT);

  ACanvas.Font.Name := FNT_TEXTO;

  { cabecalho: estado a direita }
  If FintAcima > 0 Then
  Begin
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Color := fCorFaixa(FAIXA_ACIMA);

    If FintAcima = 1 Then
      strStatus := '1 acima do limite'
    Else
      strStatus := IntToStr(FintAcima) + ' acima do limite';
  End
  Else
  Begin
    ACanvas.Font.Style := [];
    ACanvas.Font.Color := fCorSecundaria;

    If Length(FarrLicencas) = 1 Then
      strStatus := '1 produto'
    Else
      strStatus := IntToStr(Length(FarrLicencas)) + ' produtos';
  End;

  pTexto(ACanvas, Rect(intDir - LAR_STATUS, PAD_VER, intDir, PAD_VER + ALT_CABECALHO),
         strStatus, DT_RIGHT);

  { filete sob o cabecalho }
  pPreencher(ACanvas, Rect(PAD_HOR, PAD_VER + ALT_CABECALHO + 1,
                           intDir,  PAD_VER + ALT_CABECALHO + 2), fCorBorda);

  { todas as linhas: a lista nao e truncada, independente de quantos produtos }
  intTopo := PAD_VER + ALT_CABECALHO + ALT_FILETE;

  For intI := 0 To High(FarrLicencas) Do
  Begin
    pDesenharLinha(ACanvas, intTopo, FarrLicencas[intI]);
    intTopo := intTopo + ALT_LINHA;
  End;
end;

{*******************************************}
{* UMA LINHA: NOME, DATA-BASE, MEDIDOR OU  *}
{* 'SEM LIMITE', E A QUANTIDADE UTILIZADA  *}
{*******************************************}
procedure TQuadroLicencas.pDesenharLinha(ACanvas: TCanvas; Const AintTopo: Integer;
                                         Const AdtoLic: TdtoLicenca);
  Var
    intDir    : Integer;
    intXNome  : Integer;
    intXMeio  : Integer;
    intXNumero: Integer;
    intLarMeio: Integer;
    intTopMed : Integer;
    intLarUso : Integer;
    intXCorte : Integer;
    strNumero : String;
begin
  intDir     := FpbxQuadro.ClientWidth - PAD_HOR;
  intXNome   := PAD_HOR;
  intXMeio   := intXNome + COL_NOME + COL_VAO;
  intXNumero := intDir - COL_NUMERO;
  intLarMeio := intXNumero - COL_VAO - intXMeio;

  If intLarMeio < MIN_MEDIDOR Then
    intLarMeio := MIN_MEDIDOR;

  { ID_PRODUTO vai para a tela como esta na tabela; o nome completo no hint }
  ACanvas.Font.Name  := FNT_TEXTO;
  ACanvas.Font.Size  := 8;
  ACanvas.Font.Style := [];
  ACanvas.Font.Color := fCorTexto;

  pTexto(ACanvas, Rect(intXNome, AintTopo, intXNome + COL_NOME, AintTopo + ALT_LINHA),
         AdtoLic.strIdProduto, DT_LEFT Or DT_END_ELLIPSIS);


  If AdtoLic.intContratadas > 0 Then
  Begin
    intTopMed := AintTopo + ((ALT_LINHA - ALT_MEDIDOR) Div 2);

    pPreencher(ACanvas, Rect(intXMeio, intTopMed,
                             intXMeio + intLarMeio, intTopMed + ALT_MEDIDOR),
               fCorTrilho);

    intLarUso := Round(intLarMeio * PRC_CORTE * AdtoLic.fltUso);

    If intLarUso > intLarMeio Then
      intLarUso := intLarMeio;

    { uso maior que zero nunca desaparece por arredondamento }
    If (intLarUso < 1) And (AdtoLic.intUtilizadas > 0) Then
      intLarUso := 1;

    If intLarUso > 0 Then
    Begin
      pPreencher(ACanvas, Rect(intXMeio, intTopMed,
                               intXMeio + intLarUso, intTopMed + ALT_MEDIDOR),
                 fCorFaixa(AdtoLic.intFaixa));
    End;

    { vao de 2px na cor do fundo mais risco de 1px acima do trilho: assim a }
    { linha de corte continua visivel quando o preenchimento passa por ela  }
    intXCorte := intXMeio + Round(intLarMeio * PRC_CORTE);

    pPreencher(ACanvas, Rect(intXCorte, intTopMed,
                             intXCorte + 2, intTopMed + ALT_MEDIDOR), fCorSuperficie);

    pPreencher(ACanvas, Rect(intXCorte, intTopMed - 4,
                             intXCorte + 1, intTopMed), fCorRisco);

    strNumero := IntToStr(AdtoLic.intUtilizadas) + '/' + IntToStr(AdtoLic.intContratadas);
  End
  Else
    { sem limite contratado nao ha proporcao para desenhar: a coluna do meio
      fica vazia, so nome e quantidade }
    strNumero := IntToStr(AdtoLic.intUtilizadas);

  ACanvas.Font.Name  := FNT_NUMERO;
  ACanvas.Font.Size  := 8;
  ACanvas.Font.Style := [fsBold];
  ACanvas.Font.Color := fCorFaixa(AdtoLic.intFaixa);

  pTexto(ACanvas, Rect(intXNumero, AintTopo, intDir, AintTopo + ALT_LINHA),
         strNumero, DT_RIGHT);
end;

{*******************************************}
{* PONTO DE ENTRADA. AS TRES CONDICOES DO  *}
{* REQUISITO SAO CONFERIDAS NA CARGA       *}
{*******************************************}
procedure TQuadroLicencas.pAtualizar(Const AstrCodOpe: String; Const AblnTemaClaro: Boolean);
begin
  FblnTemaClaro := AblnTemaClaro;

  If Not TCargaLicencas.fCarregar(AstrCodOpe, FarrLicencas, FintAcima) Then
  Begin
    pDestruirControles;
    Exit;
  End;

  pCriarControles;

  If Not Assigned(FpnlBorda) Then
    Exit;

  { o tema pode ter mudado desde a ultima chamada }
  FpnlBorda.Color  := fCorBorda;
  FpnlQuadro.Color := fCorSuperficie;

  pMontarHint;
  pPosicionar;

  FpbxQuadro.Invalidate;
end;

end.
