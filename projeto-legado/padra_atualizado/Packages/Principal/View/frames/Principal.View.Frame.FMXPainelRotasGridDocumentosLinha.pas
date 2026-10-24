unit Principal.View.Frame.FMXPainelRotasGridDocumentosLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.Effects, System.ImageList, FMX.ImgList, System.Rtti, FMX.Grid,
  FMX.ScrollBox, FMX.Memo, Principal.View.Interfaces;

type
  TframeGridDocumentosLinha = class(TFrame)
    recBordas: TRectangle;
    layFundo: TLayout;
    recFundoBranco: TRectangle;
    efeSombra1: TShadowEffect;
    lblDocsValorRota: TLabel;
    lblDocsValorCliente: TLabel;
    lblDocsValorDataRomaneio: TLabel;
    lblDocsValorDataBaixa: TLabel;
    imgDocsFotos: TImage;
    imgDocsObs: TImage;
    lblDocsValorItens: TLabel;
    lblDocsValorMotorista: TLabel;
    layTopo: TLayout;
    lblDocsValorFotos: TLabel;
    lblDocsValorObs: TLabel;
    layBody: TLayout;
    Line1: TLine;
    Line2: TLine;
    imgDocsStatus: TImage;
    lblDocsValorAssinaturas: TLabel;
    imgDocsAssinaturas: TImage;
    lblDocsValorDocumento: TLabel;
    layDocsFotos: TFlowLayout;
    layDocsAssinaturas: TFlowLayout;
    layDocsObservacoes: TLayout;
    grdOcorrencias: TGrid;
    colStatus: TStringColumn;
    colData: TStringColumn;
    colOcorrencia: TStringColumn;
    imgOcorrencias: TImageList;
    recFundoMemo: TRectangle;
    txtMensagem: TText;
    scrHorizontal: THorzScrollBox;
    lblDocsValorRecebedor: TLabel;
    lblDocsImprimir: TLabel;
    imgDocsImprimir: TImage;
    lblDocsValorCidadeUF: TLabel;
    lblDocsValorPrevisaoEntrega: TLabel;
    lblDocsCadCli: TLabel;
    imgDocsCadCli: TImage;
    lblDocsValorDistanciaTempo: TLabel;
    lblDocsValorDistancia: TLabel;
    lblDocsValorTempo: TLabel;
    layColunasGridDocumentos: TGridPanelLayout;
    layBotoesImagens: TLayout;
    layDocsValorDocumento: TLayout;
    layDocsValorCLiente: TLayout;
    scrMensagem: TVertScrollBox;
    procedure ImageClick(Sender: TObject);
    procedure grdOcorrenciasGetValue(Sender: TObject; const Col, Row: Integer;
      var Value: TValue);
    procedure grdOcorrenciasDrawColumnCell(Sender: TObject;
      const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
      const Row: Integer; const Value: TValue; const State: TGridDrawStates);
    procedure grdOcorrenciasSelChanged(Sender: TObject);
  private
    { Private declarations }
    procedure PintarPesquisa(Canvas: TCanvas; Rect: TRectF; Linha, Coluna: Integer);
    function LinhaSelecionada(Linha: Integer): Boolean;
  public
    { Public declarations }
    arrOcorrencias : Array Of Array Of String;
    arrMensagens : Array Of AnsiString;
    objFuncoes: IFuncoes;
  end;

implementation

{$R *.fmx}

uses Principal.View.FMXVisualizarImagem, Principal.View.FMXPainelEntregas;

{ TframeGridRomaneiosLinha }


procedure TframeGridDocumentosLinha.grdOcorrenciasDrawColumnCell(
  Sender: TObject; const Canvas: TCanvas; const Column: TColumn;
  const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  LRect: TRectF;
begin
  Bounds.Height := 20;

  If LinhaSelecionada(Row) Then
    Canvas.Fill.Color := TAlphaColorRec.Lightskyblue
  Else
    Canvas.Fill.Color := TAlphaColorRec.White;

  If Column = colStatus Then
  Begin
    LRect := Bounds;

    Canvas.FillRect(Bounds, 0, 0, AllCorners, 1);

    LRect.Top    := LRect.Top + 3;
    LRect.Height := LRect.Height - 4;

    PintarPesquisa(Canvas, LRect, Row, Column.Index);
  End
  Else
  Begin
    Canvas.FillRect(Bounds, 0, 0, AllCorners, 1);

    Canvas.Fill.Color  := TAlphaColorRec.Black;
    Canvas.Font.Family := 'Segoe UI';
    Canvas.Font.Size   := 11;
    Canvas.FillText(Bounds, Value.AsString, False, 1, [], TTextAlign.Leading);
  End;
end;

procedure TframeGridDocumentosLinha.grdOcorrenciasGetValue(Sender: TObject;
  const Col, Row: Integer; var Value: TValue);
begin
  if (Length(arrOcorrencias) > 0) Then
    Value := arrOcorrencias[Row][Col];
end;

procedure TframeGridDocumentosLinha.grdOcorrenciasSelChanged(Sender: TObject);
begin
  If (grdOcorrencias.Selected > -1) Then
  Begin
    txtMensagem.Text := String(arrMensagens[grdOcorrencias.Selected]);
  End;
end;

procedure TframeGridDocumentosLinha.ImageClick(Sender: TObject);
var
  LIDImagem,
  LExtensaoImg : string;
  LBitmap: TBitmap;
begin
  LIDImagem := TImage(Sender).TagString;
  if LIDImagem = '' then Exit;

  fmxVisualizarImagem := TfmxVisualizarImagem.Create(Self);
  Try
    LBitmap      := TfmxPainelEntregas(Owner).FGerenciadorImagens.ObterImagem(LIDImagem);
    LExtensaoImg := TfmxPainelEntregas(Owner).FGerenciadorImagens.ObterExtensaoImagem(LIDImagem);
    if Assigned(LBitmap) then
    begin
      fmxVisualizarImagem.imgVisualizar.Bitmap.Assign(LBitmap);
      fmxVisualizarImagem.imgVisualizar.TagString := LIDImagem + '|' + LExtensaoImg;
      fmxVisualizarImagem.Tag := 1;
      fmxVisualizarImagem.ShowModal;
    End;
  Finally
    FreeAndNil(fmxVisualizarImagem);
  End;
end;

function TframeGridDocumentosLinha.LinhaSelecionada(Linha: Integer): Boolean;
begin
  Result := False;

  If (grdOcorrencias.IsFocused) Then
    If (Linha = grdOcorrencias.Selected) Then
      Result := True;
end;

procedure TframeGridDocumentosLinha.PintarPesquisa(Canvas: TCanvas;
  Rect: TRectF; Linha, Coluna: Integer);
begin
  imgOcorrencias.Draw(Canvas, Rect,arrOcorrencias[Linha, Coluna].ToInteger);
end;

end.
