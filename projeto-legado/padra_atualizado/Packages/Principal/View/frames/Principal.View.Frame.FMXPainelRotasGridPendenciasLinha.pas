unit Principal.View.Frame.FMXPainelRotasGridPendenciasLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox,
  Principal.View.Frame.FMXPainelRotasGridItemALiberarLinha,
  TaEntregue.Romaneios.Interfaces, FMX.Effects, FMX.Ani;

type
  TframePendencias = class(TFrame)
    recBordas: TRectangle;
    recFundoDocumentos: TRectangle;
    lblNumero: TLabel;
    lblCliente: TLabel;
    lblDataBaixa: TLabel;
    lblValorNumero: TLabel;
    lblValorCliente: TLabel;
    lblValorDataBaixa: TLabel;
    lstItens: TListBox;
    lstItem1: TListBoxItem;
    layCenter: TLayout;
    efeSombra: TShadowEffect;
    frameItemALiberar1: TframeItemALiberar;
    btnLiberarTodos: TRectangle;
    imgLiberar: TImage;
    btnNaoLiberarTodos: TRectangle;
    imgNaoLiberar: TImage;
    layDocumentos: TLayout;
    lblRomaneio: TLabel;
    lblValorRomaneio: TLabel;
    lblMotorista: TLabel;
    lblValorMotorista: TLabel;
    layRomaneio: TLayout;
    layMotorista: TLayout;
    layDocumento: TLayout;
    layCliente: TLayout;
    layDataBaixa: TLayout;
    layObs: TLayout;
    lblObs: TLabel;
    lblValorObs: TLabel;
    recRomaneio: TRectangle;
    recObs: TRectangle;
    recMotorista: TRectangle;
    recDocumento: TRectangle;
    recDataBaixa: TRectangle;
    recCLiente: TRectangle;
    VertScrollBox1: TVertScrollBox;
    procedure btnLiberarTodosClick(Sender: TObject);
    procedure btnNaoLiberarTodosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pendencias : IPendencia;

    procedure CarregaItens(Documento : IDocumento; DocIndex: Integer);
    procedure LimparItens;
  end;

implementation

{$R *.fmx}

{ TframePendencias }

procedure TframePendencias.btnLiberarTodosClick(Sender: TObject);
var
  I, J: Integer;
  ListItem: TListBoxItem;
  Frame: TframeItemALiberar;
begin
  btnNaoLiberarTodos.Opacity := 1;
  btnLiberarTodos.Opacity := 0;

  btnNaoLiberarTodos.HitTest := True;
  btnLiberarTodos.HitTest := False;

  for I := 0 to lstItens.Count - 1 do
  begin
    ListItem := lstItens.ListItems[I];

    Frame := nil;
    for J := 0 to ListItem.ComponentCount - 1 do
    begin
      if ListItem.Components[J] is TframeItemALiberar then
      begin
        Frame := TframeItemALiberar(ListItem.Components[J]);
        Break;
      end;
    end;

    if (Frame <> nil) and (Frame.imgLiberar <> nil) then
    begin
      Frame.imgLiberarClick(Frame.imgLiberar);
    end;
  end;
end;

procedure TframePendencias.btnNaoLiberarTodosClick(Sender: TObject);
var
  I, J: Integer;
  ListItem: TListBoxItem;
  Frame: TframeItemALiberar;
begin
  btnLiberarTodos.Opacity := 1;
  btnNaoLiberarTodos.Opacity := 0;

  btnLiberarTodos.HitTest := True;
  btnNaoLiberarTodos.HitTest := False;

  for I := 0 to lstItens.Count - 1 do
  begin
    ListItem := lstItens.ListItems[I];

    Frame := nil;
    for J := 0 to ListItem.ComponentCount - 1 do
    begin
      if ListItem.Components[J] is TframeItemALiberar then
      begin
        Frame := TframeItemALiberar(ListItem.Components[J]);
        Break;
      end;
    end;

    if (Frame <> nil) and (Frame.imgNaoLiberar <> nil) then
    begin
      Frame.imgNaoLiberarClick(Frame.imgNaoLiberar);
    end;
  end;
end;

procedure TframePendencias.CarregaItens(Documento: IDocumento; DocIndex: Integer);
var
  Item: IItem;
  Count: Integer;
  ListItem: TListBoxItem;
  Frame: TframeItemALiberar;
begin
  Count := 0;
  LimparItens;

  lstItens.BeginUpdate;
  try
    for Item in Documento.Itens do
    begin
      Inc(Count);

      ListItem := TListBoxItem.Create(nil);
      try
        ListItem.Selectable := False;
        ListItem.Height := 45;

        Frame := TframeItemALiberar.Create(ListItem);
        try
          Frame.Name := 'FrameItens' + Count.ToString;
          Frame.Parent := ListItem;
          Frame.Align := TAlignLayout.Contents;
          Frame.Pendencias := Pendencias;

          // Configuração dos valores
          Frame.lblValorCodigo.Text := Item.CodigoItem;
          Frame.lblValorProduto.Text := Item.Item;
          Frame.lblValorPedido.Text := FormatFloat('#,##0.00', Item.Quantidade);
          Frame.lblValorAvariada.Text := FormatFloat('#,##0.00', Item.QuantidadeAvariada);
          Frame.lblValorFaltante.Text := FormatFloat('#,##0.00', Item.QuantidadeFaltante);
          Frame.lblValorEntregue.Text := FormatFloat('#,##0.00', Item.QuantidadeEntregue);
          Frame.lblValorLiberar.Tag := DocIndex;

          Frame.imgNaoLiberar.Opacity := 1;
          Frame.imgNaoLiberar.HitTest := True;
          Frame.imgNaoLiberar.Tag := Count - 1;

          Frame.imgLiberar.Opacity := 0;
          Frame.imgLiberar.HitTest := False;
          Frame.imgLiberar.Tag := Count - 1;

          ListItem.Parent := lstItens;
        except
          Frame.Free;
          raise;
        end;
      except
        ListItem.Free;
        raise;
      end;
    end;

    if Count = 1 then
    begin
      lstItens.Align := TAlignLayout.VertCenter;
      lstItens.Height := 45;
    end
    else
      lstItens.Align := TAlignLayout.Client;
  finally
    lstItens.EndUpdate;
  end;
end;

procedure TframePendencias.LimparItens;
var
  I: Integer;
  ListItem: TListBoxItem;
  J: Integer;
  Comp: TComponent;
begin
  for I := lstItens.Count - 1 downto 0 do
  begin
    ListItem := lstItens.ListItems[I];

    for J := ListItem.ComponentCount - 1 downto 0 do
    begin
      Comp := ListItem.Components[J];
      if Comp is TframeItemALiberar then
      begin
        TframeItemALiberar(Comp).Free;
        Break;
      end;
    end;

    ListItem.Free;
  end;
  lstItens.Clear;
end;

end.
