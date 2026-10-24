{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************PZ*}
unit untPanelCxBanner;

interface
Uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  strUtils,
  Classes,
  untClassPanelCx,
  untPnlBanner,
  untFuncoesSimples,
  BitBtnLockedIncrem,
  untFatComboVenda,
  untCadPro,
  untGerMat,
  untNovoProduto;

Type

  TPanelCxBanner = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlBannerClass;

    procedure pAjustaBannerInterna;
    procedure pCarregaBanner;
  public
    frmPnlCon: TfrmPnlBanner;
    strNomForm: String;
    strTabPre : String;
    strCodCli : String;

    constructor Create(TfrmPnlCon: TfrmPnlBannerClass); reintroduce;
    procedure pCriaForm(NewDockSite  : TWinControl;
                        DropControl  : TControl;
                        cdsConsulta  : TUniClientDataSet;
                        btnConfirma  : TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

constructor TPanelCxBanner.Create(TfrmPnlCon: TfrmPnlBannerClass);
begin
  inherited Create;
  FTfrmCo   := TfrmPnlCon;
  strCodCli := '';
end;

procedure TPanelCxBanner.pCarregaBanner;
begin

  If (fEmptyStr(strTabPre)) Then
    strTabPre := '1';

  If (MidStr(fCfgSis('BANVEN', VarString), 1,1) = '1') Then
  Begin
    frmPnlCon.pnlBanner.Visible := True;
    frmPnlCon.pnlComVen.Visible := True;
    frmPnlCon.splComVen.Visible := True;

    If (Not Assigned(frmPnlCon.objComVen)) Then
      frmPnlCon.objComVen := TComVen.Create(Nil);

    frmPnlCon.objComVen.setCodEmp(VS_strCodEmp);
    frmPnlCon.objComVen.pCarregaProdutosParaBanner(strTabPre);
    frmPnlCon.dtsComVen.DataSet := frmPnlCon.objComVen.getcdsBanner;
  End;

  If (MidStr(fCfgSis('BANVEN', VarString), 2,1) = '1') Then
  Begin
    frmPnlCon.pnlBanner.Visible := True;
    frmPnlCon.pnlPromoc.Visible := True;
    frmPnlCon.splPromoc.Visible := True;

    If (Not Assigned(frmPnlCon.objPromoc)) Then
      frmPnlCon.objPromoc := TItemPromo.Create;

    frmPnlCon.objPromoc.strCodCli := strCodCli;
    frmPnlCon.objPromoc.pCarregaProdutosParaBanner;
    frmPnlCon.dtsPromoc.DataSet := frmPnlCon.objPromoc.getcdsBanner;
  End;

  If (MidStr(fCfgSis('BANVEN', VarString), 3,1) = '1') Then
  Begin
    frmPnlCon.pnlBanner.Visible := True;
    frmPnlCon.pnlEstrut.Visible := True;
    frmPnlCon.splEstrut.Visible := True;

    If (Not Assigned(frmPnlCon.objEstrut)) Then
      frmPnlCon.objEstrut := TGerMat.Create(Nil);

    frmPnlCon.objEstrut.pCarregaProdutosParaBanner(strTabPre);
    frmPnlCon.dtsEstrut.DataSet := frmPnlCon.objEstrut.getcdsBanner;
  End;

  If (MidStr(fCfgSis('BANVEN', VarString), 4,1) = '1') Then
  Begin
    frmPnlCon.pnlBanner.Visible := True;
    frmPnlCon.pnlNovProd.Visible := True;
    frmPnlCon.splNovProd.Visible := True;

    If (Not Assigned(frmPnlCon.objNovPro)) Then
      frmPnlCon.objNovPro := TNovProd.Create(Nil);

    frmPnlCon.objNovPro.pCarregaProdutosParaBanner(strTabPre);
    frmPnlCon.dtsNovProd.DataSet := frmPnlCon.objNovPro.getcdsBanner;
  End;

  prcAtualizar;

end;


procedure TPanelCxBanner.pCriaForm(NewDockSite: TWinControl;
                                 DropControl  : TControl;
                                 cdsConsulta  : TUniClientDataSet;
                                 btnConfirma  : TBitBtnLocked;
                                 cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPanel  := frmPnlCon;
  prcAtualizar := pAjustaBannerInterna;
  pCarregaBanner;

  pgcDropControl := DropControl;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxBanner.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TPanelCxBanner.pAjustaBannerInterna;
Var
  intPnlVis: Integer;
begin
  intPnlVis := 0;

  frmPnlCon.WindowState := wsMaximized;

  If (frmPnlCon.pnlBanner.Visible) Then
  Begin
    If (frmPnlCon.pnlComVen.Visible) Then
      Inc(intPnlVis);

    If (frmPnlCon.pnlPromoc.Visible) Then
      Inc(intPnlVis);

    If (frmPnlCon.pnlEstrut.Visible) Then
      Inc(intPnlVis);

    If (frmPnlCon.pnlNovProd.Visible) Then
      Inc(intPnlVis);
  End;

  If (intPnlVis > 0) Then
  Begin
    If (frmPnlCon.pnlComVen.Visible) Then
    Begin
      //frmPnlCon.pnlComVen.Height  := Trunc((intAltTel - (30 * intPnlVis)) / intPnlVis);
      frmPnlCon.pnlComVen.Height  := Trunc((intAltTel - 31) / intPnlVis);

      If (frmPnlCon.pnlComVen.Height > intAltTel - 10) Then
        frmPnlCon.pnlComVen.Height := intAltTel - 10;

      frmPnlCon.splComVen.MinSize := frmPnlCon.pnlComVen.Height;
    End;

    If (frmPnlCon.pnlPromoc.Visible) Then
    Begin
      //frmPnlCon.pnlPromoc.Height  := Trunc((intAltTel - (30 * intPnlVis)) / intPnlVis);
      frmPnlCon.pnlPromoc.Height  := Trunc((intAltTel - 31) / intPnlVis);

      If (frmPnlCon.pnlPromoc.Height > intAltTel - 10) Then
        frmPnlCon.pnlPromoc.Height := intAltTel - 10;

      frmPnlCon.splPromoc.MinSize := frmPnlCon.pnlPromoc.Height;
    End;

    If (frmPnlCon.pnlEstrut.Visible) Then
    Begin
      //frmPnlCon.pnlEstrut.Height  := Trunc((intAltTel - (30 * intPnlVis)) / intPnlVis);
      frmPnlCon.pnlEstrut.Height  := Trunc((intAltTel - 31) / intPnlVis);

      If (frmPnlCon.pnlEstrut.Height > intAltTel - 10) Then
        frmPnlCon.pnlEstrut.Height := intAltTel - 10;

      frmPnlCon.splEstrut.MinSize := frmPnlCon.pnlEstrut.Height;
    End;

    If (frmPnlCon.pnlNovProd.Visible) Then
    Begin
      //frmPnlCon.pnlEstrut.Height  := Trunc((intAltTel - (30 * intPnlVis)) / intPnlVis);
      frmPnlCon.pnlNovProd.Height  := Trunc((intAltTel - 31) / intPnlVis);

      If (frmPnlCon.pnlNovProd.Height > intAltTel - 10) Then
        frmPnlCon.pnlNovProd.Height := intAltTel - 10;

      frmPnlCon.splNovProd.MinSize := frmPnlCon.pnlNovProd.Height;
    End;

    frmPnlCon.tmrBanner.Enabled := True;
  End;
end;

end.
