unit untFormulacaoIndustrialAdvanceTintoSystem;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untFormulacaoIndustrialNova, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
   Graphics, frxClass, frxExportCSVTestabilidade;

type
  TfrmFormulacaoIndustrialAdvanceTintoSystem = class(TfrmFormulacaoIndustrialNova)
    procedure FormShow(Sender: TObject);
    procedure lsvFormulacaoAdvancedCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  private
    const BASE_COLORANTE_CAPTION: string = 'Catalisador';
    procedure PintarLista(Sender: TCustomListView; Item: TListItem);  
    { Private declarations }
  public
    { Public declarations }
    strIdePro: String;
  end;

var
  frmFormulacaoIndustrialAdvanceTintoSystem: TfrmFormulacaoIndustrialAdvanceTintoSystem;

implementation

uses
   untFormulaIndustrial, untTintaMaquina, untFuncoesSimples;

{$R *.dfm}


procedure TfrmFormulacaoIndustrialAdvanceTintoSystem.FormShow(Sender: TObject);
var
  componente: TComponenteIndustrial;
  intContador: Integer;
  novo: TListItem;
  blnBaseCatalisador: Boolean;

  strDesCol   : String;
  strCodIte   : String;
  strCodColRet: String;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := strCodCol;

    If (Not fEmptyStr(strIdePro)) Then
    Begin
      pRetItemEDescricaoColorante(strIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

      If (Not fEmptyStr(strDesCol)) Then
      Begin
        Result := Result + '-' + strDesCol;
      End;
    End;
  end;

begin
  blnBaseCatalisador := False;
  For intContador := 0 To formula.Count - 1 Do
  Begin
    componente := TComponenteIndustrial(formula.Items[intContador]);
    if (formula.Personalizada and (componente.Tipo = tciBase))
      or ((componente.Tipo = tciCatalisador) and (formula.UsaCatalisador)) then
    begin
      blnBaseCatalisador := True;
      Break;
    end;

  End;

  For intContador := 0 To formula.Count - 1 Do
  Begin
    componente := TComponenteIndustrial(formula.Items[intContador]);
    if (componente.Tipo in [tciBase, tciCatalisador]) then
      Continue;

    novo := lsvFormulacao.Items.Add;
    novo.Caption := fDescricaoColorante(componente.CodigoComponente);
    novo.SubItems.Add(FloatToStrF(componente.Quantidade * componente.PesoEspecifico, ffFixed, 12, 3));
    novo.SubItems.Add(FloatToStrF(componente.Quantidade, ffFixed, 12, 3));
    novo.SubItems.Add(FloatToStrF(componente.PrecoVenda , ffFixed, 12, 6));
  End;

  if blnBaseCatalisador then
  begin
    lsvFormulacao.Items.Add;
    novo := lsvFormulacao.Items.Add;
    novo.Caption := BASE_COLORANTE_CAPTION;
  end;

  For intContador := 0 To formula.Count - 1 Do
  Begin
    componente := TComponenteIndustrial(formula.Items[intContador]);
    if (not formula.UsaCatalisador) and (componente.Tipo = tciCatalisador) then
      Continue;

    // Exibe a base somente se o volume for personalisado
    if (componente.Tipo = tciBase) and (not formula.Personalizada) then
      Continue;

    if componente.Tipo = tciColorante then
      Continue;

    novo := lsvFormulacao.Items.Add;
    novo.Caption := fDescricaoColorante(componente.CodigoComponente);
    novo.SubItems.Add(FloatToStrF(componente.Quantidade * componente.PesoEspecifico, ffFixed, 12, 3));
    novo.SubItems.Add(FloatToStrF(componente.Quantidade, ffFixed, 12, 3));
    if (componente.Tipo <> tciCatalisador) or formula.Personalizada then
      novo.SubItems.Add(FloatToStrF(componente.PrecoVenda , ffFixed, 12, 6));
  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Add(formula.TextoCalculo);
end;

procedure TfrmFormulacaoIndustrialAdvanceTintoSystem.lsvFormulacaoAdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  PintarLista(Sender, Item);
end;

procedure TfrmFormulacaoIndustrialAdvanceTintoSystem.lsvFormulacaoAdvancedCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
  SubItem: Integer; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  PintarLista(Sender, Item);
end;

procedure TfrmFormulacaoIndustrialAdvanceTintoSystem.PintarLista(Sender: TCustomListView; Item: TListItem);
begin
  if Item.Caption = BASE_COLORANTE_CAPTION then
  begin
    Sender.Canvas.Font.Style := [fsBold];
    Sender.Height := 306;
  end
  else
  begin
    Sender.Canvas.Font.Style := [];
    Sender.Height := 204;    
  end;
end;


end.
