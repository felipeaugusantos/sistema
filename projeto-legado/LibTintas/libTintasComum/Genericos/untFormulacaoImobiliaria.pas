{*************************************************************}
{* Tela onde é exibida a formulação de uma tinta imobiliária *}
{**********************************************************PH*}
unit untFormulacaoImobiliaria;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untPai, StdCtrls, ExtCtrls, ComCtrls,
  untAbstractFormulaImobiliaria, AppEvnts, Graphics,
  Buttons, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Vcl.Menus, untAbstractLibTintaImobiliaria;

type
  TfrmFormulacaoImobiliaria = class(TfrmPai)
    lsvFormulacao: TListView;
    pnlRodape: TPanel;
    memCalculo: TMemo;
    Label1: TLabel;
    procedure lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure lsvFormulacaoAdvancedCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
  private
    blnTemCatalisador:Boolean;
    const BASE_COLORANTE_CAPTION: string = 'Catalisador';
    const BASE_: String = 'Base';
    procedure PintarLista(Sender: TCustomListView; Item: TListItem);
    { Private declarations }
    procedure pCarregarAdvanceTintoSystem;
    procedure pCarregarFormulasAdvanceTintoSystem;
    procedure pCarregarFormulasDistinct;
  public
    { Public declarations }
    formula: TAbstractFormulaImobiliaria;
  end;

var
  frmFormulacaoImobiliaria: TfrmFormulacaoImobiliaria;

implementation

uses
  untColorante, untAutcomTintaFactory;

{$R *.dfm}

procedure TfrmFormulacaoImobiliaria.FormShow(Sender: TObject);
begin
  inherited;
  Formula.pAjustaFormulacao(lsvFormulacao, frmFormulacaoImobiliaria);

  If Formula.fMostrarFormulacaoIndustrial Then
  Begin
    If Formula.GetIdePro = 'ADT' Then
      pCarregarFormulasAdvanceTintoSystem;
  End
  Else If Formula.fAlteraFormulacao Then
    formula.pAddItemsFormulacao(lsvFormulacao, Formula)
  Else
    pCarregarFormulasDistinct;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(formula.TextoInformativoCalculo);
end;

procedure TfrmFormulacaoImobiliaria.lsvFormulacaoAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;
  PintarLista(Sender, Item);
end;

procedure TfrmFormulacaoImobiliaria.lsvFormulacaoAdvancedCustomDrawSubItem(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;
  PintarLista(Sender, Item);
end;

procedure TfrmFormulacaoImobiliaria.pCarregarAdvanceTintoSystem;
begin
  lsvFormulacao.Columns.Clear;
  frmFormulacaoImobiliaria.ClientWidth := 600;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Colorante';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Quantidade(GR)';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Quantidade(ML)';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Preço';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Embalagem';
    Width := (lsvFormulacao.Width - 10) div 5;
  End;

end;

procedure TfrmFormulacaoImobiliaria.pCarregarFormulasAdvanceTintoSystem;
Var
  intContador: Integer;
  Colorante: TColorante;
begin
  blnTemCatalisador := False;

  pCarregarAdvanceTintoSystem;

  For intContador := 0 To formula.Count - 1 Do
  Begin
    Colorante := TColorante(formula.Items[intContador]);

    If ((Formula.Personalizada) And (Colorante.Tipo = tciBase)) Or
      ((Colorante.Tipo = tciCatalisador) And (Formula.UsaCatalisador)) Then
    Begin
      blnTemCatalisador := True;
      Break;
    End;
  End;

  For intContador := 0 To Formula.Count - 1 Do
  Begin

    Colorante := TColorante(formula.Items[intContador]);

    If (Colorante.Tipo in [tciBase, tciCatalisador]) Then
      Continue;

    With lsvFormulacao.Items.Add Do
    Begin

      If Not (colorante.DescricaoColorante = '') Then
        Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
      Else
        Caption := Colorante.CodigoColorante;


      SubItems.Add(FloatToStrF(Colorante.Quantidade * Colorante.PesoEspecifico, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));
      SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));

    End;
  End;

  If blnTemCatalisador Then
  Begin
    With lsvFormulacao.Items.Add Do
      Caption := BASE_COLORANTE_CAPTION;
  End;

  For intContador := 0 To formula.Count -1 Do
  Begin
    Colorante := TColorante(formula.Items[intContador]);

    If (Not formula.UsaCatalisador) And (Colorante.Tipo = tciCatalisador) Then
      Continue;

    If (Colorante.Tipo = tciBase) And (Not formula.Personalizada) Then
      Continue;

    If (Colorante.Tipo = tciColorante) Then
      Continue;


    With lsvFormulacao.Items.Add Do
    Begin
      If Not (Colorante.DescricaoColorante = '') Then
        Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
      Else
        Caption := Colorante.CodigoColorante;

      SubItems.Add(FloatToStrF(Colorante.Quantidade * Colorante.PesoEspecifico, ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Colorante.Quantidade, ffFixed, 12, 3));
      If (Colorante.Tipo <> tciCatalisador) Or (Formula.Personalizada) Then
        SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6))
      Else
        SubItems.Add('');
      SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
    End;
  End;
end;

procedure TfrmFormulacaoImobiliaria.pCarregarFormulasDistinct;
Var
  Colorante : TColorante;
  intContador: Integer;
  strOnca:String;
begin
  For intContador := 0 To formula.Count-1 Do
  Begin
    colorante := TColorante(formula.Items[intContador]);

    If Colorante.Embalagem <= 0 Then
      lsvFormulacao.Columns[3].Caption := '';

    If Colorante.PesoEspecifico > 0 Then
      lsvFormulacao.Columns[3].Caption := 'Peso Específico';

    With lsvFormulacao.Items.Add Do
    Begin

      if colorante.DescricaoColorante <> '' then
        Caption := colorante.CodigoColorante + ' - '+ colorante.DescricaoColorante
      else
        Caption := colorante.CodigoColorante;

      If formula.fMostraQuantidadeAutomatica(colorante.Quantidade) Then
      Begin
        subItems.Add(FloatToStrF(colorante.Quantidade * 4 , ffFixed, 12, 3));
      End;

      If formula.fMostraQuantidadeEmOnca(strOnca, colorante.Quantidade) Then
        SubItems.Add(strOnca)
      Else If (formula.GetIdePro = 'SHE') Then
        SubItems.Add(FloatToStrF(colorante.Quantidade, ffFixed, 12, 4))
      Else
        SubItems.Add(FloatToStrF(colorante.Quantidade, ffFixed, 12, 3));

      SubItems.Add(FloatToStrF(colorante.PrecoVenda, ffFixed, 12, 6));

      If Colorante.PesoEspecifico > 0 Then //Brasimix imobiliaria
      Begin
        SubItems.Add(FloatToStrF(Colorante.PesoEspecifico, ffFixed, 12, 4));
      End
      Else
      If Colorante.Embalagem > 0 Then
      Begin
        SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
      End;

    End;

  End;
end;

procedure TfrmFormulacaoImobiliaria.PintarLista(Sender: TCustomListView;
  Item: TListItem);
begin
  If Item.Caption = BASE_COLORANTE_CAPTION Then
  Begin
    Sender.Canvas.Font.Style := [fsBold];
    Sender.Height := 306;
  End
  Else If Item.Caption = BASE_ Then
  Begin
    Sender.Canvas.Font.Style := [fsBold];
    Sender.Height := 306;
  End
  Else
  Begin
    Sender.Canvas.Font.Style := [];
    Sender.Height := 204;
  End;
end;

end.
