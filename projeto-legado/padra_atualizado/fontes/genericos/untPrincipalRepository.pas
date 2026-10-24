unit untPrincipalRepository;

interface

uses Windows, Classes, untFuncoesSimples, System.Generics.Collections, Vcl.ExtCtrls,
  cxClasses, dxRibbonBackstageViewGalleryControl, dxRibbonBackstageView,
  dxGalleryControl, dxRibbon, cxLabel, Vcl.Controls, Vcl.Graphics, cxControls,
  SysUtils, Uni, StrUtils, Vcl.Forms;

Type
  TEventOnClick = procedure(Sender: TObject) of object;

  TPrincipalRepository = Class
  Private
    FGrupo     : String;
    FSubGrupo  : String;
    FNome      : String;
    FHint      : String;
    FID        : Integer;
    FClick     : TEventOnClick;
    FVisible   : Boolean;
    FImageIndex: Integer;
  Public
    Constructor Create(AGroup, ASubGrupo, AName, AHint: String; AId: Integer; AClick: TEventOnClick; AVisible: Boolean; AImageIndex: Integer);

    property strGrupo   : String        Read FGrupo      Write FGrupo;
    property strSubGrupo: String        Read FSubGrupo   Write FSubGrupo;
    property strNome    : String        Read FNome       Write FNome;
    property strHint    : String        Read FHint       Write FHint;
    property Id         : Integer       Read FID         Write FID;
    property onClick    : TEventOnClick Read FClick      Write FClick;
    property Visible    : Boolean       Read FVisible    Write FVisible;
    property ImageIndex : Integer       Read FImageIndex Write FImageIndex;
  End;

  TBackStage = procedure(obj: TPrincipalRepository) of object;
  TArrayRepository = Array Of TPrincipalRepository;

  TMenuRepository = Class
  Private
    procedure pCriaMenuBackstageView(obj: TPrincipalRepository);
    procedure pBackGalleryPesquisaItemClick(Sender: TObject; AItem: TdxRibbonBackstageViewGalleryItem);

    procedure pGrupoCadastros(tmrMensagem, tmrTemMsg: TTimer);
    procedure pGrupoFaturamento(blnVerificaTef: Boolean);
    procedure pGrupoFinanceiro;
    procedure pGrupoTeleatendimento;
    procedure pGrupoCancelamentoDocumento;
    procedure pGrupoLivroFiscal;
    procedure pGrupoMovimentacaoItem;
    procedure pGrupoFechamentoMensal;
    procedure pGrupoTintaMaquina;
    procedure pGrupoCrm;
    procedure pGrupoRelCadastro;
    procedure pGrupoRelEstoque;
    procedure pGrupoRelFinanceiro;
    procedure pGrupoRelEstatistica;
    procedure pGrupoRelFiscais;
    procedure pGrupoRelFaturamento;
    procedure pGrupoRelPedidoVenda;
    procedure pGrupoRelSuvinil;
    procedure pGrupoRelCrm;
    procedure pGrupoUtil;
    procedure pGrupoDireitoAcesso;
  Public
    procedure pCriaRepositorio(Princ: TForm; Ribbon: TdxRibbon; Menu: TdxRibbonBackstageView; tmrMensagem, tmrTemMsg: TTimer; blnVerificaTef: Boolean);
  End;

  function fFindMenuByID(Menu: TdxRibbonBackstageView; ID: Integer): TdxRibbonBackstageViewGalleryItem;
  function fFindMenuByHint(Menu: TdxRibbonBackstageView; Hint: String): TdxRibbonBackstageViewGalleryItem;
  function fFindMenuTabByName(Menu: TdxRibbonBackstageView; Name: String): TdxRibbonBackstageViewTabSheet;
  function fFindMenuSubGroupByName(Menu: TdxRibbonBackstageView; Name: String): TdxRibbonBackstageViewGalleryGroup;
  function fCfgSisLoc(strCamCfg: String; varTipVar: TVarType = varString) : Variant;

  Var
    dxMenu        : TdxRibbonBackstageView;
    dxRibbon      : TdxRibbon;
    frmPrinc      : TForm;
    dicMenu       : TDictionary<String,TPrincipalRepository>;
    qryCfgLoc     : TUniQuery;

implementation

uses untGrupoPrincipalFinanceiro, untGrupoPrincipalFaturamento,
  untGrupoPrincipalTeleatendimento, untGrupoPrincipalCancelamentoDocumento,
  untGrupoPrincipalLivroFiscal, untGrupoPrincipalMovimentacaoItem,
  untGrupoPrincipalFechamentoMensal, untGrupoPrincipalTintaMaquina,
  untGrupoPrincipalCrm, untGrupoPrincipalCadastros,
  untGrupoPrincipalRelCadastro, untGrupoPrincipalRelFinanceiro,
  untGrupoPrincipalRelEstatistica, untGrupoPrincipalRelFiscais,
  untGrupoPrincipalRelEstoque, untGrupoPrincipalRelFaturamento,
  untGrupoPrincipalRelPedidoVenda, untGrupoPrincipalRelSuvinil,
  untGrupoPrincipalRelCrm,
  untGrupoPrincipalDireitoAcesso, untGrupoPrincipalUtil;

{ TMenuRepository }

procedure TMenuRepository.pGrupoCadastros(tmrMensagem, tmrTemMsg: TTimer);
Var
    obj: TGrupoPrincipalCadastros;
begin
  obj := TGrupoPrincipalCadastros.Create(frmPrinc, tmrMensagem, tmrTemMsg, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoCancelamentoDocumento;
  Var
    obj: TGrupoPrincipalCancelamentoDocumento;
begin
  obj := TGrupoPrincipalCancelamentoDocumento.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoCrm;
Var
    obj: TGrupoPrincipalCrm;
begin
  obj := TGrupoPrincipalCrm.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoDireitoAcesso;
  Var
    obj: TGrupoPrincipalDireitoAcesso;
begin
  obj := TGrupoPrincipalDireitoAcesso.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoFaturamento(blnVerificaTef: Boolean);
  Var
    obj: TGrupoPrincipalFaturamento;
begin
  obj := TGrupoPrincipalFaturamento.Create(frmPrinc, blnVerificaTef, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoFechamentoMensal;
  Var
    obj: TGrupoPrincipalFechamentoMensal;
begin
  obj := TGrupoPrincipalFechamentoMensal.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoFinanceiro;
  Var
    obj: TGrupoPrincipalFinanceiro;
begin
  obj := TGrupoPrincipalFinanceiro.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoLivroFiscal;
  Var
    obj: TGrupoPrincipalLivroFiscal;
begin
  obj := TGrupoPrincipalLivroFiscal.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoMovimentacaoItem;
  Var
    obj: TGrupoPrincipalMovimentacaoItem;
begin
  obj := TGrupoPrincipalMovimentacaoItem.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelCadastro;
  Var
    obj: TGrupoPrincipalRelCadastro;
begin
  obj := TGrupoPrincipalRelCadastro.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelCrm;
  Var
    obj: TGrupoPrincipalRelCrm;
begin
  obj := TGrupoPrincipalRelCrm.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelFaturamento;
  Var
    obj: TGrupoPrincipalRelFaturamento;
begin
  obj := TGrupoPrincipalRelFaturamento.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelFinanceiro;
  Var
    obj: TGrupoPrincipalRelFinanceiro;
begin
  obj := TGrupoPrincipalRelFinanceiro.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelEstatistica;
  Var
    obj: TGrupoPrincipalRelEstatistica;
begin
  obj := TGrupoPrincipalRelEstatistica.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelEstoque;
  Var
    obj: TGrupoPrincipalRelEstoque;
begin
  obj := TGrupoPrincipalRelEstoque.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelFiscais;
  Var
    obj: TGrupoPrincipalRelFiscais;
begin
  obj := TGrupoPrincipalRelFiscais.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelPedidoVenda;
  Var
    obj: TGrupoPrincipalRelPedidoVenda;
begin
  obj := TGrupoPrincipalRelPedidoVenda.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoRelSuvinil;
  Var
    obj: TGrupoPrincipalRelSuvinil;
begin
  obj := TGrupoPrincipalRelSuvinil.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoTeleatendimento;
  Var
    obj: TGrupoPrincipalTeleatendimento;
begin
  obj := TGrupoPrincipalTeleatendimento.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoTintaMaquina;
  Var
    obj: TGrupoPrincipalTintaMaquina;
begin
  obj := TGrupoPrincipalTintaMaquina.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pGrupoUtil;
  Var
    obj: TGrupoPrincipalUtil;
begin
  obj := TGrupoPrincipalUtil.Create(frmPrinc, pCriaMenuBackstageView);
  obj.CreateMenu;
end;

procedure TMenuRepository.pCriaRepositorio(Princ: TForm; Ribbon: TdxRibbon; Menu: TdxRibbonBackstageView; tmrMensagem, tmrTemMsg: TTimer; blnVerificaTef: Boolean);
begin
  frmPrinc  := Princ;
  dxMenu    := Menu;
  dxRibbon  := Ribbon;
  dicMenu   := TDictionary<String,TPrincipalRepository>.Create;
  qryCfgLoc := nil;

  pGrupoCadastros(tmrMensagem, tmrTemMsg);
  pGrupoFaturamento(blnVerificaTef);
  pGrupoFinanceiro;
  pGrupoTeleatendimento;
  pGrupoCancelamentoDocumento;
  pGrupoLivroFiscal;
  pGrupoMovimentacaoItem;
  pGrupoFechamentoMensal;
  pGrupoTintaMaquina;
  pGrupoCrm;
  pGrupoRelCadastro;
  pGrupoRelEstoque;
  pGrupoRelFinanceiro;
  pGrupoRelEstatistica;
  pGrupoRelFiscais;
  pGrupoRelFaturamento;
  pGrupoRelPedidoVenda;
  pGrupoRelSuvinil;
  pGrupoRelCrm;
  pGrupoUtil;
  pGrupoDireitoAcesso;
end;

{ TPrincipalRepository }

constructor TPrincipalRepository.Create(AGroup, ASubGrupo, AName, AHint: String; AId: Integer; AClick: TEventOnClick; AVisible: Boolean; AImageIndex: Integer);
begin
  FGrupo     := AGroup;
  FSubGrupo  := ASubGrupo;
  FNome      := AName;
  FHint      := AHint;
  FID        := AId;
  FClick     := AClick;
  FVisible   := AVisible;
  FImageIndex:= AImageIndex;
end;

function fFindMenuByID(Menu: TdxRibbonBackstageView; ID: Integer): TdxRibbonBackstageViewGalleryItem;
  Var
    intCnt: Integer;
    item: TcxComponentCollectionItem;
Begin

  item := Nil;
  For intCnt := 0 To Menu.ComponentCount -1 Do
  Begin

    If Menu.Components[intCnt] Is TdxRibbonBackstageViewGalleryControl Then
    Begin
      item := TdxRibbonBackstageViewGalleryControl(Menu.Components[intCnt]).Gallery.Groups.FindItemByID(ID);

      If Item <> Nil Then
        Break;
    End

  End;

  If item = Nil Then
    Result := Nil
  Else
    Result := TdxRibbonBackstageViewGalleryItem(item);
End;

function fFindMenuByHint(Menu: TdxRibbonBackstageView; Hint: String): TdxRibbonBackstageViewGalleryItem;
  Var
    intCnt: Integer;

    function fFindByHint(ctrl: TdxRibbonBackstageViewGalleryControl): TdxRibbonBackstageViewGalleryItem;
      Var
        intGru,
        intIte: Integer;
    Begin
      Result := Nil;
      For intGru := 0 To ctrl.Gallery.Groups.Count - 1 Do
      Begin
        For intIte := 0 To ctrl.Gallery.Groups[intGru].Items.Count - 1 Do
        Begin
          If ctrl.Gallery.Groups[intGru].Items[intIte].Hint = Hint Then
          Begin
            Result := ctrl.Gallery.Groups[intGru].Items[intIte];
            Break;
          End;
        End;

        If Result <> Nil Then Break;
      End;
    End;

Begin

  Result := Nil;
  For intCnt := 0 To Menu.ComponentCount -1 Do
  Begin
    If Menu.Components[intCnt] Is TdxRibbonBackstageViewGalleryControl Then
    Begin
      Result := fFindByHint(TdxRibbonBackstageViewGalleryControl(Menu.Components[intCnt]));
      If Result <> Nil Then Break;
    End;
  End;

End;

function fFindMenuSubGroupByName(Menu: TdxRibbonBackstageView; Name: String): TdxRibbonBackstageViewGalleryGroup;
  Var
    intCnt: Integer;

    function fFindByName(ctrl: TdxRibbonBackstageViewGalleryControl): TdxRibbonBackstageViewGalleryGroup;
      Var
        intGru: Integer;
    Begin
      Result := Nil;
      For intGru := 0 To ctrl.Gallery.Groups.Count - 1 Do
      Begin
        If ctrl.Gallery.Groups[intGru].Caption = Name Then
        Begin
          Result := ctrl.Gallery.Groups[intGru];
          Break;
        End;
      End;
    End;

Begin

  Result := Nil;
  For intCnt := 0 To Menu.ComponentCount -1 Do
  Begin
    If Menu.Components[intCnt] Is TdxRibbonBackstageViewGalleryControl Then
    Begin
      Result := fFindByName(TdxRibbonBackstageViewGalleryControl(Menu.Components[intCnt]));
      If Result <> Nil Then Break;
    End;
  End;

End;

function fFindMenuTabByName(Menu: TdxRibbonBackstageView; Name: String): TdxRibbonBackstageViewTabSheet;
  Var
    intCnt: Integer;
Begin

  Result := Nil;
  For intCnt := 0 To Menu.TabCount -1 Do
  Begin
    If Menu.Tabs[intCnt].Caption = Name Then
    Begin
      Result := Menu.Tabs[intCnt];
      Break;
    End;
  End;

End;

procedure TMenuRepository.pCriaMenuBackstageView(obj: TPrincipalRepository);
  Var
    ATab  : TdxRibbonBackstageViewTabSheet;
    ACtrl : TdxRibbonBackstageViewGalleryControl;
    AGroup: TdxRibbonBackstageViewGalleryGroup;
    AItem : TdxRibbonBackstageViewGalleryItem;
    ALabel: TcxLabel;

  procedure pCriaLabel;
  Begin
    ALabel := TcxLabel.Create(dxMenu);
    ALabel.Parent := ATab;
    ALabel.Align := alTop;
    ALabel.AutoSize := False;
    ALabel.Caption := 'Selecione uma opção';
    ALabel.ParentFont := False;
    ALabel.Style.Font.Charset := DEFAULT_CHARSET;
    ALabel.Style.Font.Color := clWindowText;
    ALabel.Style.Font.Height := -16;
    ALabel.Style.Font.Name := 'Tahoma';
    ALabel.Style.Font.Style := [];
    ALabel.Style.TransparentBorder := False;
    ALabel.Properties.Alignment.Horz := taCenter;
    ALabel.Properties.LineOptions.Alignment := cxllaBottom;
    ALabel.Properties.LineOptions.Visible := True;
    ALabel.Transparent := True;
  End;

  procedure pCriaCtrl;
  Begin
    ACtrl := TdxRibbonBackstageViewGalleryControl.Create(dxMenu);
    ACtrl.Parent := ATab;
    ACtrl.Align := alClient;
    ACtrl.Font.Charset := DEFAULT_CHARSET;
    ACtrl.Font.Color := clWindowText;
    ACtrl.Font.Height := -11;
    ACtrl.Font.Name := 'Segoe UI';
    ACtrl.Font.Style := [fsBold];
    ACtrl.BorderStyle := cxcbsNone;
    ACtrl.OptionsView.ColumnAutoWidth := True;
    ACtrl.OptionsView.ColumnCount := 1;
    ACtrl.OptionsView.ContentOffset.All := 0;
    ACtrl.OptionsView.Item.Text.AlignHorz := taLeftJustify;
    ACtrl.OptionsView.Item.Text.AlignVert := vaCenter;
    ACtrl.OptionsView.Item.Text.Position := posRight;
    ACtrl.OptionsView.Item.PinMode := bgipmTag;
    ACtrl.Ribbon := dxRibbon;
    ACtrl.OnItemClick := pBackGalleryPesquisaItemClick;
  End;

  function fGetCtrl: TdxRibbonBackstageViewGalleryControl;
    Var
      intCnt: Integer;
  Begin

    Result := Nil;
    For intCnt := 0 To ATab.ControlCount -1 Do
    Begin

      If ATab.Controls[intCnt] Is TdxRibbonBackstageViewGalleryControl Then
      Begin
        Result := TdxRibbonBackstageViewGalleryControl(ATab.Controls[intCnt]);
        Break;
      End;
    End;

  End;

Begin
  AGroup := Nil;
  ACtrl  := Nil;
  ATab   := Nil;

  ATab := fFindMenuTabByName(dxMenu, obj.strGrupo);

  If ATab <> Nil Then
    ACtrl := fGetCtrl;

  If (Assigned(ACtrl)) And (ACtrl.Gallery.Groups.Count > 0) Then
    AGroup := fFindMenuSubGroupByName(dxMenu, obj.strSubGrupo);

  If ATab = Nil Then
  Begin
    ATab := dxMenu.AddTab;
    ATab.Caption := obj.strGrupo;

    pCriaLabel;
    pCriaCtrl;
  End;

  If (AGroup = Nil) Then
  Begin
    AGroup := ACtrl.Gallery.Groups.Add;
    AGroup.Caption := obj.strSubGrupo;
    AGroup.ShowCaption := (obj.strSubGrupo <> '');
  End;

  AItem := AGroup.Items.Add;
  AItem.Caption := obj.strNome;
  AItem.Hint := obj.strHint;
  Aitem.Tag := obj.Id;
  //AItem.Glyph.GetAsBitmap;  ver
End;

procedure TMenuRepository.pBackGalleryPesquisaItemClick(Sender: TObject; AItem: TdxRibbonBackstageViewGalleryItem);
begin
  dicMenu[AItem.Hint].onClick(Sender);
end;

function fCfgSisLoc(strCamCfg: String; varTipVar: TVarType = varString) : Variant;
  Var
    strValCfg: String;

  procedure pIniCfgLoc;
  Begin
    qryCfgLoc := fCriaQuery();
    qryCfgLoc.Close;
    qryCfgLoc.SQL.Clear;
    qryCfgLoc.SQL.Add('SELECT * FROM CFGSIS WHERE SIS_CODEMP = ' + QuotedStr( VS_strCodEmp));
    qryCfgLoc.Open;
  End;

Begin
  if (not Assigned(qryCfgLoc)) then
    pIniCfgLoc;

  qryCfgLoc.Filter := 'SIS_CODCFG = ' + QuotedStr('CFG_' + strCamCfg);
  qryCfgLoc.Filtered := True;

  strValCfg := qryCfgLoc.FieldByName('SIS_VALCFG').AsString;

  Case varTipVar Of
    varString : Result := strValCfg;

    varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                Begin
                  Try
                    If fEmptyStr(strValCfg) Then
                      Result := 0
                    Else
                      Result := strToInt(strValCfg);
                  Except
                    Result := 0;
                  End;
                End;

    varDouble, varCurrency:
                Begin
                  Try
                    If fEmptyStr(strValCfg) Then
                      Result := 0.00
                    Else
                      Result := fStrToFloat(AnsiReplaceStr(strValCfg, '.', ','));
                  Except
                    Result := 0.00;
                  End;
                End;

    varDate:
                Begin
                  Try
                    If fEmptyStr(strValCfg) Then
                      Result := 0
                    Else
                      Result := strToDate(strValCfg);
                  Except
                    Result := 0;
                  End;
                End;

    varBoolean:
               Begin
                 Try
                   If fEmptyStr(strValCfg) Then
                     Result := False
                   Else If Pos(strValCfg, 'S_N_') > 0 Then
                     Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

                   Else If Pos(strValCfg, '0_1_') > 0  Then
                     Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
                   Else
                     Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

                 Except
                   Result := False;
                 End;

               End;

    Else
      Result := strValCfg;

  End;
End;

end.
