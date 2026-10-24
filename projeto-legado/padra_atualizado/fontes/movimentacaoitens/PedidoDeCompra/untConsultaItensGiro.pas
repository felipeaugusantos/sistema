unit untConsultaItensGiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaCds, DB, UniClientDataSet, ExtCtrls, StdCtrls, ComCtrls,
  Buttons, Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils,
  Uni, BitBtnLockedIncrem, Datasnap.DBClient, DBMemoFocus, untCadProFoto,
  System.ImageList, Vcl.ImgList;

type
  TfrmConsultaItensGiro = class(TfrmConsultaCds)
    pnlGiro: TPanel;
    pnlItem: TPanel;
    lblSugest: TLabel;
    lblSaldos: TLabel;
    lblMes: TLabel;
    Label3: TLabel;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    lblTitMarBr2: TLabel;
    lblTitPreVe2: TLabel;
    lblMedia: TLabel;
    lblTitMarBr3: TLabel;
    lblTitPreVe3: TLabel;
    lblTitMarBr4: TLabel;
    lblTitPreVe4: TLabel;
    dbeMes: TDBEditFocus;
    dbeSaldos: TDBEditFocus;
    dbeSugest: TDBEditFocus;
    dbePreVe1: TDBEditFocus;
    dbeMarBr1: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbePreVe2: TDBEditFocus;
    dbeMarBr2: TDBEditFocus;
    edtValMedia: TEditFocus;
    dbeMarBr3: TDBEditFocus;
    dbePreVe3: TDBEditFocus;
    dbePreVe4: TDBEditFocus;
    dbeMarBr4: TDBEditFocus;
    pnlMeses: TPanel;
    lblVendas: TLabel;
    lblMes01: TLabel;
    lblMes02: TLabel;
    lblMes03: TLabel;
    lblMes04: TLabel;
    lblMes05: TLabel;
    lblMes06: TLabel;
    lblMes07: TLabel;
    lblMes08: TLabel;
    lblMes09: TLabel;
    lblMes10: TLabel;
    lblMes11: TLabel;
    lblMes12: TLabel;
    dbeMes01: TDBEditFocus;
    dbeMes02: TDBEditFocus;
    dbeMes04: TDBEditFocus;
    dbeMes03: TDBEditFocus;
    dbeMes06: TDBEditFocus;
    dbeMes05: TDBEditFocus;
    dbeMes12: TDBEditFocus;
    dbeMes11: TDBEditFocus;
    dbeMes10: TDBEditFocus;
    dbeMes09: TDBEditFocus;
    dbeMes08: TDBEditFocus;
    dbeMes07: TDBEditFocus;
    grpUltFornecedor: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtDesForUlt: TEditFocus;
    edtDTAULT: TEditFocus;
    edtPREULT: TEditFocus;
    edtFORULT: TEditFocus;
    lblTitMarBr5: TLabel;
    dbeMarBr5: TDBEditFocus;
    lblTitPreVe5: TLabel;
    dbePreVe5: TDBEditFocus;
    lblTitMarBr6: TLabel;
    dbeMarBr6: TDBEditFocus;
    lblTitPreVe6: TLabel;
    dbePreVe6: TDBEditFocus;
    dbePesoit: TDBEditFocus;
    Label4: TLabel;
    lblTitMarBr7: TLabel;
    lblTitPreVe7: TLabel;
    dbeMarBr7: TDBEditFocus;
    dbePreVe7: TDBEditFocus;
    btnMostraEstoque: TBitBtnLocked;
    Panel2: TPanel;
    lblAplica: TLabel;
    dbeAplica: TDBMemoFocus;
    pnlImagem: TPanel;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblErrImg: TLabel;
    imglImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
  private

    blnImgPro: Boolean;

    procedure pMontaValoresGiro;
    procedure pRetDadUltCompra(strCodIte: String);

    Function fValidaCampos(arrCampo: Array Of String): Boolean;

    { Private declarations }
  protected
    procedure pAtuIndice(intIndice: Integer); override;
    procedure pAfterScroll(DataSet: TDataSet); override;
  public
    { Public declarations }
    intQtdMes: Integer;
    dtaDataBaseGir: TDateTime;
    blnConsMesAtu: Boolean;
    sltItems: TStringList;
  end;

var
  frmConsultaItensGiro: TfrmConsultaItensGiro;

implementation

uses untFuncoesSimples, untFatMostraEstoqueEmp;

{$R *.dfm}

{*****************************************}
{* MONTA OS EDITS PARA MOSTRAR OS VALORES*}
{* REFERENTES AO GIRO                    *}
{**************************************MV*}
procedure TfrmConsultaItensGiro.pMontaValoresGiro;
  Var
    lblTemp: TLabel;
    dbeTemp: TDBEditFocus;
    intContador: Integer;
begin

  edtValMedia.Text := '0,00';

  For intContador := 1 To intQtdMes Do
  Begin

    lblTemp := (fComponentByName(pnlMeses, 'lblMes' + fStrZero(IntToStr(intContador), 2)) As TLabel);
    dbeTemp := (fComponentByName(pnlMeses, 'dbeMes' + fStrZero(IntToStr(intContador), 2)) As TDBEditFocus);

//    lblTemp.Caption   := cdsConsulta.FieldbyName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).AsString;
    lblTemp.Caption := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, - intContador));
    lblTemp.Visible   := True;

    dbeTemp.DataField := cdsConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).FieldName;
    dbeTemp.Visible   := True;

    cdsConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).Visible := False;
    TFloatField(cdsConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2))).DisplayFormat := '#,##0.00';

    cdsConsulta.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2)).Visible := False;
    TFloatField(cdsConsulta.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2))).DisplayFormat := '#,##0.00';

    cdsConsulta.FieldByName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).Visible := False;

  End;
  cdsConsulta.FieldByName('TAB').DisplayWidth := 4;
  cdsConsulta.FieldByName('ITE_SUGEST').Visible := False;
  cdsConsulta.FieldByName('ITE_SALFIS').Visible := False;
  cdsConsulta.FieldByName('ITE_PRECUS').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR1').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE1').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR2').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE2').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR3').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE3').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR4').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE4').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR5').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE5').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR6').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE6').Visible := False;
  cdsConsulta.FieldByName('ITE_MARBR7').Visible := False;
  cdsConsulta.FieldByName('ITE_PREVE7').Visible := False;

  cdsConsulta.FieldByName('ITE_LITROS').Visible := False;
  cdsConsulta.FieldByName('ITE_PESOIT').Visible := False;

  TFloatField(cdsConsulta.FieldByName('ITE_SUGEST')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_SALFIS')).DisplayFormat := '#,###0.000';
  TFloatField(cdsConsulta.FieldByName('ITE_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR1')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE1')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR2')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE2')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR3')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE3')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR4')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE4')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR5')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE5')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR6')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE6')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_MARBR7')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVE7')).DisplayFormat := '#,##0.00';

  TFloatField(cdsConsulta.FieldByName('ITE_LITROS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PESOIT')).DisplayFormat := '#,##0.00';

  pRetDadUltCompra(cdsConsulta.FieldByName('ITE_CODITE').AsString);

end;

procedure TfrmConsultaItensGiro.pRetDadUltCompra(strCodIte: String);
//  Var
//    qryConTmp : TUniQuery;
//    strSQL    : String;
begin
  edtDTAULT.Clear;
  edtPREULT.Clear;
  edtFORULT.Clear;
  edtDesForUlt.Clear;

(*
  qryConTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_DTAULT, ';
  strSQL := strSQL + '  ITE_PREULT, ';
  strSQL := strSQL + '  ITE_FORULT, ';
  strSQL := strSQL + '  FOR_NOMFOR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = ITE_FORULT AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  With qryConTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If Not( IsEmpty ) Then
    Begin
      If qryConTmp.FieldByName('ITE_DTAULT').AsDateTime = 0 Then
        edtDTAULT.Clear
      Else
        edtDTAULT.Text  := FormatDateTime('dd/mm/yyyy', qryConTmp.FieldByName('ITE_DTAULT').AsDateTime);
      edtPREULT.Text    := FormatFloat('#,##0.00', qryConTmp.FieldByName('ITE_PREULT').AsFloat);
      edtFORULT.Text    := qryConTmp.FieldByName('ITE_FORULT').AsString;
      edtDesForUlt.Text := qryConTmp.FieldByName('FOR_NOMFOR').AsString;
    End;

    Close;
  End;
  *)

  If (Not cdsConsulta.FieldByName('ITE_DTAULT').IsNull) And
      (cdsConsulta.FieldByName('ITE_DTAULT').AsDateTime <> 0) Then
    edtDTAULT.Text := FormatDateTime('dd/mm/yyyy', cdsConsulta.FieldByName('ITE_DTAULT').AsDateTime);

   edtPREULT.Text    := FormatFloat('#,##0.00', cdsConsulta.FieldByName('ITE_PREULT').AsFloat);
   edtFORULT.Text    := cdsConsulta.FieldByName('ITE_FORULT').AsString;
   edtDesForUlt.Text := cdsConsulta.FieldByName('ITE_NOMFOR').AsString;
end;


procedure TfrmConsultaItensGiro.FormShow(Sender: TObject);
begin
  inherited;
  pMontaValoresGiro;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  btnMostraEstoque.Visible := VS_blnTemFil;

  blnImgPro := fCfgSis('IMGPRO') = 'S';

  dbeMarBr1.Visible    := VS_strTabPrc[1] = 'S';
  dbePreVe1.Visible    := VS_strTabPrc[1] = 'S';;
  lblTitMarBr1.Visible := VS_strTabPrc[1] = 'S';
  lblTitPreVe1.Visible := VS_strTabPrc[1] = 'S';

  dbeMarBr2.Visible    := VS_strTabPrc[2] = 'S';
  dbePreVe2.Visible    := VS_strTabPrc[2] = 'S';;
  lblTitMarBr2.Visible := VS_strTabPrc[2] = 'S';
  lblTitPreVe2.Visible := VS_strTabPrc[2] = 'S';

  dbeMarBr3.Visible    := VS_strTabPrc[3] = 'S';
  dbePreVe3.Visible    := VS_strTabPrc[3] = 'S';;
  lblTitMarBr3.Visible := VS_strTabPrc[3] = 'S';
  lblTitPreVe3.Visible := VS_strTabPrc[3] = 'S';

  dbeMarBr4.Visible    := VS_strTabPrc[4] = 'S';
  dbePreVe4.Visible    := VS_strTabPrc[4] = 'S';;
  lblTitMarBr4.Visible := VS_strTabPrc[4] = 'S';
  lblTitPreVe4.Visible := VS_strTabPrc[4] = 'S';

  dbeMarBr5.Visible    := VS_strTabPrc[5] = 'S';
  dbePreVe5.Visible    := VS_strTabPrc[5] = 'S';;
  lblTitMarBr5.Visible := VS_strTabPrc[5] = 'S';
  lblTitPreVe5.Visible := VS_strTabPrc[5] = 'S';

  dbeMarBr6.Visible    := VS_strTabPrc[6] = 'S';
  dbePreVe6.Visible    := VS_strTabPrc[6] = 'S';;
  lblTitMarBr6.Visible := VS_strTabPrc[6] = 'S';
  lblTitPreVe6.Visible := VS_strTabPrc[6] = 'S';

  dbeMarBr7.Visible    := VS_strTabPrc[7] = 'S';
  dbePreVe7.Visible    := VS_strTabPrc[7] = 'S';;
  lblTitMarBr7.Visible := VS_strTabPrc[7] = 'S';
  lblTitPreVe7.Visible := VS_strTabPrc[7] = 'S';

  If dbgConsulta.Enabled Then
    pSetFocus(dbgConsulta);

  pAfterScroll(cdsConsulta);
end;

procedure TfrmConsultaItensGiro.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pRetDadUltCompra(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmConsultaItensGiro.btnMostraEstoqueClick(Sender: TObject);
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  inherited;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.strCodIte    := cdsConsulta.FieldByName('ITE_CODITE').AsString;
    frmFatMostraEstoqueEmp.strTabPre    := '1';
    frmFatMostraEstoqueEmp.edtItem.Text := cdsConsulta.FieldByName('ITE_CODITE').AsString + ' - ' +
                                           cdsConsulta.FieldByName('ITE_DESITE').AsString;
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);

end;

procedure TfrmConsultaItensGiro.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Column.Field.FieldName = 'TAB' Then
  Begin
    If Pos(cdsConsulta.FieldByName('ITE_CODITE').AsString, sltItems.CommaText) > 0 Then
    Begin
      TDBGridCitel(Sender).Canvas.FillRect(Rect);
      imglImageList.Draw(TDBGridCitel(Sender).Canvas, Rect.Left + 1, Rect.Top + 1,1);
    End;
  End;
end;

procedure TfrmConsultaItensGiro.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pRetDadUltCompra(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmConsultaItensGiro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  
  Case Key Of
    VK_ESCAPE: btnSair.Click;
    VK_F6    : btnMostraEstoque.Click;
  End;
end;

procedure TfrmConsultaItensGiro.pAfterScroll(DataSet: TDataSet);
//  Var
 //   intContador: Integer;
//    fltMedia: Double;

  procedure pMascaraFrac(strCampo: String);
  begin
    If Frac(cdsConsulta.FieldByName(strCampo).AsFloat) = 0 Then
    Begin
      TFloatField(cdsConsulta.FieldByName(strCampo)).DisplayFormat := '#0';
    End
    Else
    Begin
      TFloatField(cdsConsulta.FieldByName(strCampo)).DisplayFormat := '#,##0.00';
    End;
  end;

begin
  inherited;
  pRetDadUltCompra(cdsConsulta.FieldByName('ITE_CODITE').AsString);

  pMascaraFrac('ITE_SUGEST');
  pMascaraFrac('ITE_SALFIS');
  pMascaraFrac('ITE_VENMES');
  pMascaraFrac('ITE_Q_VPME');
  pMascaraFrac('ITE_QTDPEN');
  pMascaraFrac('ITE_SALREQ');
  pMascaraFrac('ITE_MAQTSA');

  If cdsConsulta.FieldByName('ITE_MEDIA_').IsNull Then
    edtValMedia.Text := ''
  Else
    edtValMedia.Text := FloatToStrF(cdsConsulta.FieldByName('ITE_MEDIA_').AsFloat, ffNumber, 12, 2);

  If fValidaCampos(['ITE_CODITE']) Then
    TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, cdsConsulta.FieldByName('ITE_CODITE').AsString);

end;

procedure TfrmConsultaItensGiro.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgConsulta);
end;

procedure TfrmConsultaItensGiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsConsulta.AfterScroll := Nil;

end;

Function TfrmConsultaItensGiro.fValidaCampos(arrCampo: Array Of String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not Assigned(cdsConsulta.FindField(arrCampo[intContador])) Then
    Begin
      Result := False;
      Exit;
    End;
End;

end.
