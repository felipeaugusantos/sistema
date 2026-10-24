unit untFatImpostos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, untFuncoesSimples, DB, BitBtnLockedIncrem, Grids,
  DBGridCitel, DBGrids, untFuncFat, UniClientDataSet, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, untFuncFatTypes;

type
  TfrmFatImpostos = class(TfrmPai)
    pnlBusca: TPanel;
    pnlDados: TPanel;
    pnlVendedor: TPanel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblEndereco: TLabel;
    edtEndereco: TEditFocus;
    Label2: TLabel;
    edtBairro: TEditFocus;
    edtCEP: TEditFocus;
    Label3: TLabel;
    edtCidade: TEditFocus;
    Label4: TLabel;
    edtCPF: TEditFocus;
    Label6: TLabel;
    edtRG: TEditFocus;
    Panel1: TPanel;
    edtDescricao: TEditFocus;
    Label7: TLabel;
    Label5: TLabel;
    edtReferencia: TEditFocus;
    Label8: TLabel;
    edtUnidade: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    edtTotPro: TEditFocus;
    edtTbcICM: TEditFocus;
    edtTbcIPI: TEditFocus;
    edtTbcRet: TEditFocus;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label11: TLabel;
    edtDesEsp: TEditFocus;
    edtTotICM: TEditFocus;
    edtTotIPI: TEditFocus;
    edtTotRet: TEditFocus;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtTotFre: TEditFocus;
    edtDesAce: TEditFocus;
    edtTotGer: TEditFocus;
    Label16: TLabel;
    Label18: TLabel;
    dtsVenda: TDataSource;
    dbgItens: TDBGridCitel;
    Label1: TLabel;
    edtTbcFCP: TEditFocus;
    edtClaIpi: TEditFocus;
    lblClaIpi: TLabel;
    edtTotPis: TEditFocus;
    lblTotPis: TLabel;
    edtTbcPis: TEditFocus;
    lblTbcPis: TLabel;
    edtTotCof: TEditFocus;
    lblTotCof: TLabel;
    edtTbcCof: TEditFocus;
    lblTbcCof: TLabel;
    lblTitIBS: TLabel;
    lblTitIS: TLabel;
    lblTitVlrCBS: TLabel;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    edtTotCBS: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fltTotNovoCBS: Double;
    fltTotNovoIBS: Double;
    fltTotNovoIS : Double;
    procedure pAtualizaEditsImpostos;
    procedure pAfterScroll(Dataset: TDataset);      
    procedure pSetaVisibilidadeColunaDesonerado;
    procedure pSetaVisibilidadeColunasCdsImpostos;
    procedure pSetaVisibilidadeNovosImpostos;
    procedure pAcumulaTotaisNovosImpostos;
    function fGetTotIte(const item: TDadosFechamento): Double;
    function fVaiExibirDesoneracaoZonaFranca: Boolean;
  public
    { Public declarations }
    fatVenda : TFatVenda;
    prcScroll: TprcScroll;
    cdsDados : TUniClientDataSet;
    fltTotGer: Double;
    cdsImpostosEspelho: TUniClientDataSet;
  protected

  end;

var
  frmFatImpostos: TfrmFatImpostos;

implementation

uses StrUtils, untFuncoesGenerica, untReformaTributariaTipos;

{$R *.dfm}

{ TfrmFatImpostos }

procedure TfrmFatImpostos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := fCriaTemporaria(Self);
  pCloneDataSet(cdsDados, cdsVenda);  

  dtsVenda.DataSet     := cdsDados;
  cdsDados.AfterScroll := pAfterScroll;
end;

function TfrmFatImpostos.fGetTotIte(const item: TDadosFechamento): Double;
begin
  Result := item.fltTotIte - item.fltDesEsp;
  If fVaiExibirDesoneracaoZonaFranca Then
    Result := item.fltTotIte - (item.fltDesEsp - item.fltIcmOrg);
end;

procedure TfrmFatImpostos.FormShow(Sender: TObject);
  Var
    intCont : Integer;
    blnForcarDadosCdsImpostos: Boolean;
begin
  inherited;
  blnForcarDadosCdsImpostos := (fatVenda.strOpcDoc = 'GF') and fatVenda.blnConfirmacaoEspelho;
  cdsDados.DisableControls;

  if blnForcarDadosCdsImpostos then
  begin
    cdsImpostosEspelho.First;
    While Not cdsImpostosEspelho.Eof do
    begin
      If cdsDados.Locate('AUTOINCREM', cdsImpostosEspelho.FieldByName('ITE_AUTINC').AsString, []) Then
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('ITE_DESSIM').AsString:= cdsImpostosEspelho.FieldByName('ITE_DESITE').AsString;
        cdsDados.FieldByName('ABF_CODSIT').AsString:= cdsImpostosEspelho.FieldByName('ITE_CODSIT').AsString;
        cdsDados.FieldByName('ITE_TOTITE').AsFloat := cdsImpostosEspelho.FieldByName('ITE_TOTITE').AsFloat;
        cdsDados.FieldByName('ITE_BASICM').AsFloat := cdsImpostosEspelho.FieldByName('ITE_BASICM').AsFloat;
        cdsDados.FieldByName('ITE_ALQICM').AsFloat := cdsImpostosEspelho.FieldByName('ITE_ALQICM').AsFloat;
        cdsDados.FieldByName('ITE_VALICM').AsFloat := cdsImpostosEspelho.FieldByName('ITE_VALICM').AsFloat;
        cdsDados.FieldByName('ITE_BASIPI').AsFloat := cdsImpostosEspelho.FieldByName('ITE_BASIPI').AsFloat;
        cdsDados.FieldByName('ITE_ALQIPI').AsFloat := cdsImpostosEspelho.FieldByName('ITE_ALQIPI').AsFloat;
        cdsDados.FieldByName('ITE_VALIPI').AsFloat := cdsImpostosEspelho.FieldByName('ITE_VALIPI').AsFloat;
        cdsDados.FieldByName('ITE_BASRET').AsFloat := cdsImpostosEspelho.FieldByName('ITE_BASRET').AsFloat;
        cdsDados.FieldByName('ITE_VALRET').AsFloat := cdsImpostosEspelho.FieldByName('ITE_VALRET').AsFloat;
        cdsDados.Post;
      End;
      cdsImpostosEspelho.Next;
    end;
  end
  else begin
    With fatVenda Do
    Begin
      For intCont := Low(arrMatItens) To High(arrMatItens) Do
      Begin
        With cdsDados Do
        Begin
          If Locate('AUTOINCREM', arrMatItens[intCont].intAutInc, []) Then
          Begin
            Edit;
            FieldByName('ITE_DESSIM').AsString:= IIF(fEmptyStr(fRetNomSimplificadoProduto(arrMatItens[intCont].strCodIte)),
                                                       arrMatItens[intCont].strDesIte,
                                                       fRetNomSimplificadoProduto(arrMatItens[intCont].strCodIte));

            FieldByName('ITE_CLAFIS').AsString:= arrMatItens[intCont].strClaFis;
            FieldByName('ABF_CODSIT').AsString:= arrMatItens[intCont].strCodFis;
            FieldByName('ITE_TOTITE').AsFloat := fGetTotIte(arrMatItens[intCont]);
            FieldByName('ITE_BASICM').AsFloat := arrMatItens[intCont].fltBasIcm;
            FieldByName('ITE_ALQICM').AsFloat := arrMatItens[intCont].fltAlqIcm;
            FieldByName('ITE_VALICM').AsFloat := arrMatItens[intCont].fltValIcm;
            FieldByName('ITE_BASIPI').AsFloat := arrMatItens[intCont].fltBasIpi;
            FieldByName('ITE_ALQIPI').AsFloat := arrMatItens[intCont].fltAlqIPI;
            FieldByName('ITE_VALIPI').AsFloat := arrMatItens[intCont].fltValipi;
            FieldByName('ITE_BASRET').AsFloat := arrMatItens[intCont].fltBasRet;
            FieldByName('ITE_VALRET').AsFloat := arrMatItens[intCont].fltValRet;
            FieldByName('ITE_CSTPIS').AsString:= arrMatItens[intCont].strCSTPis;
            FieldByName('ITE_BASPIS').AsFloat := arrMatItens[intCont].fltBasPis;
            FieldByName('ITE_ALQPIS').AsFloat := arrMatItens[intCont].fltAlqPis;
            FieldByName('ITE_VALPIS').AsFloat := arrMatItens[intCont].fltValPis;
            FieldByName('ITE_CSTCOF').AsString:= arrMatItens[intCont].strCSTCof;
            FieldByName('ITE_BASCOF').AsFloat := arrMatItens[intCont].fltBasCof;
            FieldByName('ITE_ALQCOF').AsFloat := arrMatItens[intCont].fltAlqCof;
            FieldByName('ITE_VALCOF').AsFloat := arrMatItens[intCont].fltValCof;

            FieldByName('ABF_CODSIT').AsString  := fatVenda.fRetornaCstDiferimento(FieldByName('ITE_BASICM').AsFloat,
                                                                                   FieldByName('ABF_CODSIT').AsString);

            FieldByName('ITE_ICMORG').AsFloat := arrMatItens[intCont].fltIcmOrg;

            FieldByName('ITE_VALCBS').AsFloat := arrMatItens[intCont].fltValCBS;
            FieldByName('ITE_VALIBS').AsFloat := arrMatItens[intCont].fltValIBS;
            FieldByName('ITE_VAL_IS').AsFloat := arrMatItens[intCont].fltVal_IS;

            Post;
          End;
        End;
      End;
    End;
  end;
  cdsDados.EnableControls;

  pAcumulaTotaisNovosImpostos;

  pSetaVisibilidadeColunaDesonerado;
  pSetaVisibilidadeNovosImpostos;
  pSetaVisibilidadeColunasCdsImpostos;
  pSetFocus(dbgItens);
  pAtualizaEditsImpostos;
end;

function TfrmFatImpostos.fVaiExibirDesoneracaoZonaFranca: Boolean;
begin
  Result := (fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms) And (fatVenda.fltIcmOrg > 0);
end;

procedure TfrmFatImpostos.pAfterScroll(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('ITE_TOTITE')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_BASICM')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_ALQICM')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALICM')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_BASIPI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_ALQIPI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALIPI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_BASRET')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALRET')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_ICMORG')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_BASPIS')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_ALQPIS')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALPIS')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_BASCOF')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_ALQCOF')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALCOF')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALCBS')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VALIBS')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('ITE_VAL_IS')).DisplayFormat := '#,##0.00';

  edtDescricao.Text  := Dataset.FieldByName('ITE_DESITE').AsString;
  edtReferencia.Text := Dataset.FieldByName('ITE_REFERE').AsString;
  edtUnidade.Text    := fRetSiglaUnidade(Dataset.FieldByName('ITE_CODUNI').AsString);
end;

procedure TfrmFatImpostos.pAtualizaEditsImpostos;
begin
  edtCodCli.Text     := fatVenda.strCodCli;
  edtNomCli.Text     := fatVenda.strCliNom;
  edtEndereco.Text   := fatVenda.strCliEnd;
  edtBairro.Text     := fatVenda.strCliBai;
  edtCEP.Text        := Copy(fatVenda.strCliCep,1,5)+'-'+Copy(fatVenda.strCliCep,6,3);
  edtCidade.Text     := fatVenda.strCliCid + ' - ' + fatVenda.strCliEst;
  edtCPF.Text        := fFormataCpfCgc(fatVenda.strCliCgc,fSetaPais);
  edtRG.Text         := fatVenda.strCli_Rg;
  edtTotPro.Text     := FormatFloat('#,##0.00', fatVenda.fltTotPro);
  edtTbcICM.Text     := FormatFloat('#,##0.00', fatVenda.fltBasIcm);
  edtTbcIPI.Text     := FormatFloat('#,##0.00', fatVenda.fltBasIpi);
  edtTbcRet.Text     := FormatFloat('#,##0.00', fatVenda.fltBasRet);
  edtDesEsp.Text     := FormatFloat('#,##0.00', fatVenda.fltDesEsp);
  edtTotICM.Text     := FormatFloat('#,##0.00', fatVenda.fltTotIcm);
  edtTotIPI.Text     := FormatFloat('#,##0.00', fatVenda.fltTotIpi);
  edtTotRet.Text     := FormatFloat('#,##0.00', fatVenda.fltTotRet);
  edtTbcFCP.Text     := FormatFloat('#,##0.00', fatVenda.fltTotFcpST);
  edtTotFre.Text     := FormatFloat('#,##0.00', fatVenda.fltValFre);
  edtDesAce.Text     := FormatFloat('#,##0.00', fatVenda.fltDesAce);
  edtTbcPis.Text     := FormatFloat('#,##0.00', fatVenda.fltTotBasPis);
  edtTotPis.Text     := FormatFloat('#,##0.00', fatVenda.fltTotPis);
  edtTbcCof.Text     := FormatFloat('#,##0.00', fatVenda.fltTotBasCof);
  edtTotCof.Text     := FormatFloat('#,##0.00', fatVenda.fltTotCof);
  edtTotCBS.Text     := FormatFloat('#,##0.00', fltTotNovoCBS);
  edtTotIBS.Text     := FormatFloat('#,##0.00', fltTotNovoIBS);
  edtTotIS.Text      := FormatFloat('#,##0.00', fltTotNovoIS);

  edtTotGer.Text     := FormatFloat('#,##0.00', fltTotGer);
end;

procedure TfrmFatImpostos.pSetaVisibilidadeColunaDesonerado;
  Var
    Column : TColumn;
begin
  Column := fFindColumnByName(dbgItens, 'ITE_ICMORG');
  If (Not Assigned(Column)) Then
    Exit;
  Column.Visible := fVaiExibirDesoneracaoZonaFranca;
end;

procedure TfrmFatImpostos.pAcumulaTotaisNovosImpostos;
  Var
    prcScrollTotais: TprcScroll;
    bkmPosicao: TBookmark;
begin
  fltTotNovoCBS := 0;
  fltTotNovoIBS := 0;
  fltTotNovoIS  := 0;

  If (Not Assigned(cdsDados)) Or (Not cdsDados.Active) Then
    Exit;

  pDisableControls(cdsDados, prcScrollTotais);
  bkmPosicao := cdsDados.GetBookmark;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      fltTotNovoCBS := fltTotNovoCBS + cdsDados.FieldByName('ITE_VALCBS').AsFloat;
      fltTotNovoIBS := fltTotNovoIBS + cdsDados.FieldByName('ITE_VALIBS').AsFloat;
      fltTotNovoIS  := fltTotNovoIS  + cdsDados.FieldByName('ITE_VAL_IS').AsFloat;

      cdsDados.Next;
    End;
  Finally
    If cdsDados.BookmarkValid(bkmPosicao) Then
      cdsDados.GotoBookmark(bkmPosicao);

    cdsDados.FreeBookmark(bkmPosicao);
    pEnableControls(cdsDados, prcScrollTotais);
  End;
end;

procedure TfrmFatImpostos.pSetaVisibilidadeNovosImpostos;
  Var
    blnExibir: Boolean;

  procedure pSetaColuna(const strCampo: String);
    Var
      Column: TColumn;
  begin
    Column := fFindColumnByName(dbgItens, strCampo);
    If Assigned(Column) Then
      Column.Visible := blnExibir;
  end;

begin
  blnExibir := fSomarNovosImpostosDaReformaAoValorContabil;

  lblTitVlrCBS.Visible := blnExibir;
  edtTotCBS.Visible    := blnExibir;
  lblTitIBS.Visible    := blnExibir;
  edtTotIBS.Visible    := blnExibir;
  lblTitIS.Visible     := blnExibir;
  edtTotIS.Visible     := blnExibir;

  pSetaColuna('ITE_VALCBS');
  pSetaColuna('ITE_VALIBS');
  pSetaColuna('ITE_VAL_IS');
end;

procedure TfrmFatImpostos.pSetaVisibilidadeColunasCdsImpostos;
begin
  If not ((fatVenda.strOpcDoc = 'GF') and fatVenda.blnConfirmacaoEspelho) Then
    Exit;

  lblTbcPis.Visible := False;
  lblTotPis.Visible := False;
  lblTbcCof.Visible := False;
  lblTotCof.Visible := False;

  edtTbcPis.Visible := False;
  edtTotPis.Visible := False;
  edtTbcCof.Visible := False;
  edtTotCof.Visible := False;

  fFindColumnByName(dbgItens, 'ITE_CLAFIS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_CSTPIS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_BASPIS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_ALQPIS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_VALPIS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_CSTCOF').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_BASCOF').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_ALQCOF').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_VALCOF').Visible := False;
end;

end.
