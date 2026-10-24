unit untFatMostraTravasMinimas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, DB, StdCtrls, EditFocus, Grids, DBGridCitel, DBGrids, AppEvnts, Menus,
  Buttons, BitBtnLockedIncrem, ExtCtrls, UniClientDataSet, Uni, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxGridCitel;

type
  TfrmFatMostraTravasMinimas = class(TfrmPai)
    dtsDados: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgTravaMinimaCODITE: TcxGridDBColumn;
    cxgTravaMinimaDESITE: TcxGridDBColumn;
    cxgTravaMinimaUNIDAD: TcxGridDBColumn;
    cxgTravaMinimaQTDITE: TcxGridDBColumn;
    cxgTravaMinimaVLRTAB: TcxGridDBColumn;
    cxgTravaMinimaTOTVLRTAB: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FcdsDados: TUniClientDataSet;
    intDecUni, intDecQtd: Integer;
    { Private declarations }
    function fTemItemTinta: Boolean;
    procedure pMontaCamposcxGrid;
    procedure pAddCollumn(strFieldName, strCaption: String; algAlignment: TAlignment; blnSum: Boolean = False);
    function fPossuiAcessoVendedorMaster: Boolean;
    function fPossuiAcessoGerenteJunior: Boolean;
    function fPossuiAcessoGerenteMaster: Boolean;
    function fPossuiAcessoSubGerenteJunior: Boolean;
    function fPossuiAcessoSubGerenteMaster: Boolean;

  public
    { Public declarations }
    property cdsDados: TUniClientDataSet Read FcdsDados Write FcdsDados;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmFatMostraTravasMinimas }

procedure TfrmFatMostraTravasMinimas.FormCreate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TfrmFatMostraTravasMinimas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmFatMostraTravasMinimas.FormShow(Sender: TObject);
begin
  inherited;
  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);

  cxGridCitel1DBTableViewCitel1.CorZebra := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  cxGridCitel1DBTableViewCitel1.Zebra := True;

  pMontaCamposcxGrid;
end;

function TfrmFatMostraTravasMinimas.fPossuiAcessoVendedorMaster: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('VEMIN', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN5', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN2', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Then
    Exit(True);

  If fCfgSis('VMNSEM', varBoolean) Then
  Begin
    If fVerificaAcessoSistema('VEMIN4', strLoginUsuarioLogado) Then
      Exit(True);
  End;
end;

function TfrmFatMostraTravasMinimas.fTemItemTinta: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsDados);
    cdsClone.Filter := 'IDEPRO <> ' + QuotedStr('NOR');
    cdsClone.Filtered := True;
    Result := (Not cdsClone.IsEmpty);
    cdsClone.Close;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmFatMostraTravasMinimas.fPossuiAcessoSubGerenteJunior: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('VEMIN5', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN2', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Then
    Exit(True);

  If fCfgSis('VMNSEM', varBoolean) Then
  Begin
    If fVerificaAcessoSistema('VEMIN', strLoginUsuarioLogado) Then
      Exit(True);
  End;
end;

function TfrmFatMostraTravasMinimas.fPossuiAcessoSubGerenteMaster: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('VEMIN2', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Then
    Exit(True);

  If fCfgSis('VMNSEM', varBoolean) Then
  Begin
    If fVerificaAcessoSistema('VEMIN5', strLoginUsuarioLogado) Then
      Exit(True);
  End;
end;

function TfrmFatMostraTravasMinimas.fPossuiAcessoGerenteJunior: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
    Exit(True);

  If fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Then
    Exit(True);

  If fCfgSis('VMNSEM', varBoolean) Then
  Begin
    If fVerificaAcessoSistema('VEMIN2', strLoginUsuarioLogado) Then
      Exit(True);
  End;
end;

function TfrmFatMostraTravasMinimas.fPossuiAcessoGerenteMaster: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Then
    Exit(True);

  If fCfgSis('VMNSEM', varBoolean) Then
  Begin
    If fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
      Exit(True);
  End;
end;

procedure TfrmFatMostraTravasMinimas.pAddCollumn(strFieldName, strCaption: String; algAlignment: TAlignment; blnSum: Boolean = False);
  Var
    intIndex: Integer;
Begin
  intIndex := cxGridCitel1DBTableViewCitel1.ColumnCount;

  cxGridCitel1DBTableViewCitel1.CreateColumn;
  cxGridCitel1DBTableViewCitel1.Columns[intIndex].DataBinding.FieldName := strFieldName;
  cxGridCitel1DBTableViewCitel1.Columns[intIndex].Caption := strCaption;
  cxGridCitel1DBTableViewCitel1.Columns[intIndex].Width := 150;

  if blnSum then
  begin
    cxGridCitel1DBTableViewCitel1.Columns[intIndex].Summary.FooterKind := skSum;
    cxGridCitel1DBTableViewCitel1.Columns[intIndex].Summary.FooterFormat := fMskDigitos(intDecUni);
  end;
End;

procedure TfrmFatMostraTravasMinimas.pMontaCamposcxGrid;
  Var
    strMascaraPercent: String;
begin
  strMascaraPercent := fMskDigitos(2)+' %';
  If (fUsaTravaPorMargemMinimaLiquida) Then
    If (fTemItemTinta) And (fAnalisaTodosCompomentesAoTravarUnitarioDeTintaComoProdutoNormal) Then
      strMascaraPercent := fMskDigitos(4)+' %';

  If SameText(VS_strTRADES, '2') Then
  Begin
    pAddCollumn('DEMAXV', 'Desc.Max.Vend.Júnior', taRightJustify);
    pAddCollumn('VLMINV', 'Vr.Min.Vend.Júnior'  , taRightJustify, True);
    pAddCollumn('TOTVLMINV', 'Vr.Tot.Min.Vend.Júnior'  , taRightJustify, True);

    (cdsDados.FieldByName('DEMAXV')  As TFloatField).DisplayFormat := strMascaraPercent;
    (cdsDados.FieldByName('VLMINV')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    (cdsDados.FieldByName('TOTVLMINV')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);

    If fPossuiAcessoVendedorMaster Then
    Begin
      pAddCollumn('DEMAVM' , 'Desc.Max.Ven.Master', taRightJustify);
      pAddCollumn('VLMIVM', 'Vr.Min.Ven.Master' , taRightJustify, True);
      pAddCollumn('TOTVLMIVM', 'Vr.Tot.Min.Ven.Master' , taRightJustify, True);

      (cdsDados.FieldByName('DEMAVM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMIVM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMIVM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoSubGerenteJunior Then
    Begin
      pAddCollumn('DEMAXS' , 'Desc.Max.Sub.Ger.Júnior', taRightJustify);
      pAddCollumn('VLMINS', 'Vr.Min.Sub.Ger.Júnior' , taRightJustify, True);
      pAddCollumn('TOTVLMINS', 'Vr.Tot.Min.Sub.Ger.Júnior' , taRightJustify, True);

      (cdsDados.FieldByName('DEMAXS')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMINS') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMINS') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoSubGerenteMaster Then
    Begin
      pAddCollumn('DEMASM' , 'Desc.Max.Sub.Ger.Master', taRightJustify);
      pAddCollumn('VLMISM', 'Vr.Min.Sub.Ger.Master' , taRightJustify, True);
      pAddCollumn('TOTVLMISM', 'Vr.Tot.Min.Sub.Ger.Master' , taRightJustify, True);

      (cdsDados.FieldByName('DEMASM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMISM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMISM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoGerenteJunior Then
    Begin
      pAddCollumn('DEMAXG', 'Desc.Max.Ger.Júnior', taRightJustify);
      pAddCollumn('VLMING', 'Vr.Min.Ger.Júnior'  , taRightJustify, True);
      pAddCollumn('TOTVLMING', 'Vr.Tot.Min.Ger.Júnior'  , taRightJustify, True);

      (cdsDados.FieldByName('DEMAXG')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMING')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMING')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoGerenteMaster Then
    Begin
      pAddCollumn('DEMAGM', 'Desc.Max.Ger.Master', taRightJustify);
      pAddCollumn('VLMIGM', 'Vr.Min.Ger.Master'  , taRightJustify, True);
      pAddCollumn('TOTVLMIGM', 'Vr.Tot.Min.Ger.Master'  , taRightJustify, True);

      (cdsDados.FieldByName('DEMAGM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMIGM')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMIGM')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;
  End
  Else
  Begin
    pAddCollumn('MRMINV' , 'Mrg.Min.Vend.Júnior', taRightJustify);
    pAddCollumn('VLMINV_', 'Vr.Min.Vend.Júnior' , taRightJustify, True);
    pAddCollumn('TOTVLMINV_', 'Vr.Tot.Min.Vend.Júnior' , taRightJustify, True);

    (cdsDados.FieldByName('MRMINV')  As TFloatField).DisplayFormat := strMascaraPercent;
    (cdsDados.FieldByName('VLMINV_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    (cdsDados.FieldByName('TOTVLMINV_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);

    If fPossuiAcessoVendedorMaster Then
    Begin
      pAddCollumn('MRMNVM' , 'Mrg.Min.Vend.Master', taRightJustify);
      pAddCollumn('VLMINVM', 'Vr.Min.Vend.Master' , taRightJustify, True);
      pAddCollumn('TOTVLMINVM', 'Vr.Tot.Min.Vend.Master' , taRightJustify, True);

      (cdsDados.FieldByName('MRMNVM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMINVM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMINVM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoSubGerenteJunior Then
    Begin
      pAddCollumn('MRMINS' , 'Mrg.Min.Sub.Ger.Júnior', taRightJustify);
      pAddCollumn('VLMINS_', 'Vr.Min.Sub.Ger.Júnior' , taRightJustify, True);
      pAddCollumn('TOTVLMINS_', 'Vr.Tot.Min.Sub.Ger.Júnior' , taRightJustify, True);

      (cdsDados.FieldByName('MRMINS')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMINS_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMINS_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoSubGerenteMaster Then
    Begin
      pAddCollumn('MRMNSM' , 'Mrg.Min.Sub.Ger.Master', taRightJustify);
      pAddCollumn('VLMINSM', 'Vr.Min.Sub.Ger.Master' , taRightJustify, True);
      pAddCollumn('TOTVLMINSM', 'Vr.Tot.Min.Sub.Ger.Master' , taRightJustify, True);

      (cdsDados.FieldByName('MRMNSM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMINSM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMINSM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoGerenteJunior Then
    Begin
      pAddCollumn('MRMING' , 'Mrg.Min.Ger.Júnior', taRightJustify);
      pAddCollumn('VLMING_', 'Vr.Min.Ger.Júnior' , taRightJustify, True);
      pAddCollumn('TOTVLMING_', 'Vr.Tot.Min.Ger.Júnior' , taRightJustify, True);

      (cdsDados.FieldByName('MRMING')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMING_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMING_') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;

    If fPossuiAcessoGerenteMaster Then
    Begin
      pAddCollumn('MRMNGM' , 'Mrg.Min.Ger.Master', taRightJustify);
      pAddCollumn('VLMINGM', 'Vr.Min.Ger.Master' , taRightJustify, True);
      pAddCollumn('TOTVLMINGM', 'Vr.Tot.Min.Ger.Master' , taRightJustify, True);

      (cdsDados.FieldByName('MRMNGM')  As TFloatField).DisplayFormat := strMascaraPercent;
      (cdsDados.FieldByName('VLMINGM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
      (cdsDados.FieldByName('TOTVLMINGM') As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
    End;
  End;

  dtsDados.DataSet := cdsDados;

  cxgTravaMinimaQTDITE.Summary.FooterFormat := fMskDigitos(intDecQtd);
  (cdsDados.FieldByName('QTDITE')  As TFloatField).DisplayFormat := fMskDigitos(intDecQtd);
  cxgTravaMinimaVLRTAB.Summary.FooterFormat := fMskDigitos(intDecUni);
  (cdsDados.FieldByName('VLRTAB')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);
  cxgTravaMinimaTOTVLRTAB.Summary.FooterFormat := fMskDigitos(intDecUni);
  (cdsDados.FieldByName('TOTVLRTAB')  As TFloatField).DisplayFormat := fMskDigitos(intDecUni);

end;

end.
