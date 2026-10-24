unit untPnlBanner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, Data.DB, cxDBData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxImage, cxLabel,
  cxCurrencyEdit, cxSplitter, Vcl.StdCtrls, cxGridLevel, dxLayoutContainer,
  cxGridViewLayoutContainer, cxGridLayoutView, cxGridCustomTableView,
  cxGridDBLayoutView, cxClasses, cxGridCustomView, cxGridCustomLayoutView,
  cxGrid, Vcl.ComCtrls, Vcl.ExtCtrls, untTypesSistema, untFuncoesSimples,
  untFatComboVenda,  untCadPro,  untGerMat, untNovoProduto,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPnlBanner = class(TForm)
    dtsComVen: TDataSource;
    dtsPromoc: TDataSource;
    dtsEstrut: TDataSource;
    tmrBanner: TTimer;
    pnlBanner: TPanel;
    pnlComVen: TPanel;
    PageControl1: TPageControl;
    tbsComVen: TTabSheet;
    cxgComVen: TcxGrid;
    cxgComVenDBLayoutView: TcxGridDBLayoutView;
    cxgComVenDBLayoutViewItem1: TcxGridDBLayoutViewItem;
    cxgComVenDBLayoutViewItem2: TcxGridDBLayoutViewItem;
    cxgComVenDBLayoutViewItem3: TcxGridDBLayoutViewItem;
    cxgComVenDBLayoutViewGroup_Root: TdxLayoutGroup;
    cxgComVenDBLayoutViewLayoutItem2: TcxGridLayoutItem;
    cxgComVenDBLayoutViewLayoutItem3: TcxGridLayoutItem;
    cxGridLayoutItem1: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    cxgComVenLevel1: TcxGridLevel;
    chkAniCom: TCheckBox;
    pnlPromoc: TPanel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    cxGrid1: TcxGrid;
    cxgPromocDBLayoutView: TcxGridDBLayoutView;
    cxGridDBLayoutViewItem1: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem2: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem3: TcxGridDBLayoutViewItem;
    dxLayoutGroup1: TdxLayoutGroup;
    cxGridLayoutItem2: TcxGridLayoutItem;
    cxGridLayoutItem3: TcxGridLayoutItem;
    cxGridLayoutItem4: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup;
    cxGridLevel1: TcxGridLevel;
    chkAniPro: TCheckBox;
    pnlEstrut: TPanel;
    PageControl3: TPageControl;
    TabSheet2: TTabSheet;
    cxGrid2: TcxGrid;
    cxgEstrutDBLayoutView: TcxGridDBLayoutView;
    cxGridDBLayoutViewItem4: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem5: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem6: TcxGridDBLayoutViewItem;
    dxLayoutGroup2: TdxLayoutGroup;
    cxGridLayoutItem5: TcxGridLayoutItem;
    cxGridLayoutItem6: TcxGridLayoutItem;
    cxGridLayoutItem7: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup3: TdxLayoutAutoCreatedGroup;
    cxGridLevel2: TcxGridLevel;
    chkAniEst: TCheckBox;
    splComVen: TcxSplitter;
    splPromoc: TcxSplitter;
    splEstrut: TcxSplitter;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlNovProd: TPanel;
    PageControl4: TPageControl;
    tbsNovProd: TTabSheet;
    cxGrid3: TcxGrid;
    cxNovProdDBLayoutView1: TcxGridDBLayoutView;
    cxGridDBLayoutViewItem7: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem8: TcxGridDBLayoutViewItem;
    cxGridDBLayoutViewItem9: TcxGridDBLayoutViewItem;
    dxLayoutGroup3: TdxLayoutGroup;
    cxGridLayoutItem8: TcxGridLayoutItem;
    cxGridLayoutItem9: TcxGridLayoutItem;
    cxGridLayoutItem10: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup4: TdxLayoutAutoCreatedGroup;
    cxGridLevel3: TcxGridLevel;
    chkAniNovProd: TCheckBox;
    splNovProd: TcxSplitter;
    dtsNovProd: TDataSource;
    cxNovProdDBLayoutView1LayoutItem1: TcxGridLayoutItem;
    cxGridDBLayoutViewItem10: TcxGridDBLayoutViewItem;
    procedure tmrBannerTimer(Sender: TObject);
    procedure cxgComVenDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgPromocDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgEstrutDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    procedure pMostraDetalhesBanner(tipTipBan: TTipBan);
    procedure pMostraDetalhesBannerCombo;
    procedure pMostraDetalhesBannerPromocao;
    procedure pMostraDetalhesBannerEstrutura;
    procedure pMostraDetalhes(strCaption: String; stlDetalhes: TStringList; tipTipBan: TTipBan);
    procedure pMovimentaComboVenda;
    procedure pMovimentaPromocao;
    procedure pMovimentaEstrutura;
    procedure pMovimentaNovoProduto;
  public
    objComVen: TComVen;
    objPromoc: TItemPromo;
    objEstrut: TGerMat;
    objNovPro: TNovProd;
  end;

  TfrmPnlBannerClass = Class Of TfrmPnlBanner;

var
  frmPnlBanner: TfrmPnlBanner;

implementation

{$R *.dfm}

uses untObsBanner;

procedure TfrmPnlBanner.cxgComVenDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pMostraDetalhesBanner(banCombo);
end;

procedure TfrmPnlBanner.cxgEstrutDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pMostraDetalhesBanner(banEstrutura);
end;

procedure TfrmPnlBanner.cxgPromocDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pMostraDetalhesBanner(banPromocao);
end;

procedure TfrmPnlBanner.FormDestroy(Sender: TObject);
begin
  If Assigned(objComVen) Then
    FreeAndNil(objComVen);

  If Assigned(objPromoc) Then
    FreeAndNil(objPromoc);

  If Assigned(objEstrut) Then
    FreeAndNil(objEstrut);

  If Assigned(objNovPro) Then
    FreeAndNil(objNovPro);
end;

procedure TfrmPnlBanner.pMostraDetalhes(strCaption: String;
  stlDetalhes: TStringList; tipTipBan: TTipBan);
Var
  intContador: Integer;
begin
  Try
    pCriarFormularios(TfrmObsBanner, frmObsBanner);

    If (tipTipBan = banEstrutura) Then
    Begin
      frmObsBanner.Height := 600;
      frmObsBanner.Width  := 766;
    End
    Else
    Begin
      frmObsBanner.Height := 290;
      frmObsBanner.Width  := 550;
    End;

    frmObsBanner.Caption := strCaption;

    For intContador := 0 To stlDetalhes.Count - 1 Do
      frmObsBanner.mmoObserv.Lines.Add(stlDetalhes[intContador]);

    frmObsBanner.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhe]');
  End;

  pFreeAndNil(frmObsBanner);

end;

procedure TfrmPnlBanner.pMostraDetalhesBanner(tipTipBan: TTipBan);
begin
  If (tipTipBan = banCombo) Then
    pMostraDetalhesBannerCombo
  Else If (tipTipBan = banPromocao) Then
    pMostraDetalhesBannerPromocao
  Else If (tipTipBan = banEstrutura) Then
    pMostraDetalhesBannerEstrutura;
end;

procedure TfrmPnlBanner.pMostraDetalhesBannerCombo;
Var
  stlDetalhes: TStringList;
  strEmpres  : String;
  blnPriReg  : Boolean;
  blnEfeAut  : Boolean;
begin

  blnEfeAut := chkAniCom.Checked;
  chkAniCom.Checked := False;

  Try

    stlDetalhes := TStringList.Create;
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('INFORMAÇÕES DETALHADAS DO COMBO DE VENDA');
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('Combo          : ' + dtsComVen.DataSet.FieldByName('DESCOM').AsString);
    stlDetalhes.Add('Tabela de Preço: ' + dtsComVen.DataSet.FieldByName('TABPRE').AsString);
    stlDetalhes.Add('Vigência       : ' + dtsComVen.DataSet.FieldByName('VIGENC').AsString);

    strEmpres := Trim(dtsComVen.DataSet.FieldByName('EMPRES').AsString);

    blnPriReg := True;

    If (Length(strEmpres) <= 52) Then
      stlDetalhes.Add('Empresas       : ' + strEmpres)
    Else
    Begin
      While (Length(strEmpres) > 0) Do
      Begin
        If (blnPriReg) Then
        Begin
          stlDetalhes.Add('Empresas       : ' + Copy(strEmpres, 1, 51));
          blnPriReg := False;
        End
        Else
          stlDetalhes.Add('                 ' + Copy(strEmpres, 1, 51));

        delete(strEmpres, 1, 53);
        strEmpres := Trim(strEmpres);
      End;
    End;

    stlDetalhes.Add(fPadR('', 72, '-'));

    pMostraDetalhes('PRODUTO: ' + dtsComVen.DataSet.FieldByName('CODITE').AsString + '-' + dtsComVen.DataSet.FieldByName('DESITE').AsString, stlDetalhes, banCombo);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerCombo]');
  End;

  FreeAndNil(stlDetalhes);

  chkAniCom.Checked := blnEfeAut;

end;

procedure TfrmPnlBanner.pMostraDetalhesBannerEstrutura;
Var
  stlDetalhes: TStringList;
  intDecQtd: Integer;
  blnEfeAut: Boolean;
begin

  blnEfeAut := chkAniEst.Checked;
  chkAniEst.Checked := False;

  Try

    intDecQtd := fCfgSis('DECQTD', VarInteger);

    objEstrut.pCarregaProdutosDaEstrutura(dtsEstrut.DataSet.FieldByName('AUTINC').AsString);

    stlDetalhes := TStringList.Create;
    stlDetalhes.Add('+-----------------------------------------------------------------------------------------------------+');
    stlDetalhes.Add('| PRODUTO ESTRUTURA: ' + fPadR(dtsEstrut.DataSet.FieldByName('CODITE').AsString + '-' + dtsEstrut.DataSet.FieldByName('DESITE').AsString, 79) + '|' );
    stlDetalhes.Add('+---------+-----------------------------------------------------------------------+------+------------+');
    stlDetalhes.Add('| CÓDIGO  | DESCRIÇÃO                                                             | UN   | QUANTIDADE |');
    stlDetalhes.Add('+---------+-----------------------------------------------------------------------+------+------------+');

    With objEstrut.getQryIteEst Do
    Begin
      First;

      While Not Eof Do
      Begin
        stlDetalhes.Add('| ' + fPadR(FieldByName('CODITE').AsString + ' | ' + FieldByName('DESITE').AsString, 77) + ' | ' + fPadR(FieldByName('SIGUNI').AsString, 04) + ' | ' + fPadL(FormatFloat(fMskDigitos(intDecQtd), FieldByName('QTDITE').AsFloat), 10) + ' |');
        stlDetalhes.Add('+---------+-----------------------------------------------------------------------+------+------------+');
        Next;
      End;
    End;

    pMostraDetalhes('Detalhes da Estrutura', stlDetalhes, banEstrutura);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerEstrutura]');
  End;

  FreeAndNil(stlDetalhes);
  chkAniEst.Checked := blnEfeAut;

end;

procedure TfrmPnlBanner.pMostraDetalhesBannerPromocao;
Var
  stlDetalhes: TStringList;
  strEmpres: String;
  blnPriReg: Boolean;
  blnEfeAut: Boolean;
begin

  blnEfeAut := chkAniPro.Checked;
  chkAniPro.Checked := False;

  Try

    stlDetalhes := TStringList.Create;
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('INFORMAÇÕES DETALHADAS DA PROMOÇÃO');
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('Promoção       : ' + dtsPromoc.DataSet.FieldByName('DESPRO').AsString);
    stlDetalhes.Add('Tabela de Preço: ' + dtsPromoc.DataSet.FieldByName('TABPRE').AsString);
    stlDetalhes.Add('Vigência       : ' + dtsPromoc.DataSet.FieldByName('VIGENC').AsString);

    strEmpres := Trim(dtsPromoc.DataSet.FieldByName('EMPRES').AsString);

    blnPriReg := True;

    If (Length(strEmpres) <= 52) Then
      stlDetalhes.Add('Empresas       : ' + strEmpres)
    Else
    Begin
      While (Length(strEmpres) > 0) Do
      Begin
        If (blnPriReg) Then
        Begin
          stlDetalhes.Add('Empresas       : ' + Copy(strEmpres, 1, 51));
          blnPriReg := False;
        End
        Else
          stlDetalhes.Add('                 ' + Copy(strEmpres, 1, 51));

        delete(strEmpres, 1, 53);
        strEmpres := Trim(strEmpres);
      End;
    End;

    stlDetalhes.Add(fPadR('', 72, '-'));

    pMostraDetalhes('PRODUTO: ' + dtsPromoc.DataSet.FieldByName('CODITE').AsString + '-' + dtsPromoc.DataSet.FieldByName('DESITE').AsString, stlDetalhes, banPromocao);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerPromocao]');
  End;

  FreeAndNil(stlDetalhes);
  chkAniPro.Checked := blnEfeAut;
end;

procedure TfrmPnlBanner.pMovimentaComboVenda;
begin
  If (Not Assigned(dtsComVen.DataSet)) Then
    Exit;

  If (Not chkAniCom.Checked) Then
    Exit;

  With dtsComVen.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmPnlBanner.pMovimentaEstrutura;
begin
  If (Not Assigned(dtsEstrut.DataSet)) Then
    Exit;

  If (Not chkAniEst.Checked) Then
    Exit;

  With dtsEstrut.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmPnlBanner.pMovimentaNovoProduto;
begin
  If (Not Assigned(dtsNovProd.DataSet)) Then
    Exit;

  If (Not chkAniNovProd.Checked) Then
    Exit;

  With dtsNovProd.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmPnlBanner.pMovimentaPromocao;
begin
  If (Not Assigned(dtsPromoc.DataSet)) Then
    Exit;

  If (Not chkAniPro.Checked) Then
    Exit;

  With dtsPromoc.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmPnlBanner.tmrBannerTimer(Sender: TObject);
begin
  If (pnlComVen.Visible) And (pnlBanner.Visible) Then
    pMovimentaComboVenda;

  If (pnlPromoc.Visible) And (pnlBanner.Visible) Then
    pMovimentaPromocao;

  If (pnlEstrut.Visible) And (pnlBanner.Visible) Then
    pMovimentaEstrutura;

  If (pnlNovProd.Visible) And (pnlBanner.Visible) Then
    pMovimentaNovoProduto;
end;

end.
