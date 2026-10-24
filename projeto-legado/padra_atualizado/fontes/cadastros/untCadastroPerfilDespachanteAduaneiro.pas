unit untCadastroPerfilDespachanteAduaneiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untTPerfilDespachanteAduaneiro,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit;

type
  TfrmCadPerfilAduaneiro = class(TfrmPaiCad)
    pnlContainer: TPanel;
    rdgValUnitarProduto: TRadioGroup;
    grpOutras: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    dbeCODPER: TDBEditFocus;
    Label2: TLabel;
    dbeDESPER: TDBEditFocus;
    chkOutSiscomex: TCheckBox;
    chkOutAfrmm: TCheckBox;
    grpValorContabil: TGroupBox;
    chkValProduto: TCheckBox;
    chkValFre: TCheckBox;
    chkIcms: TCheckBox;
    chkSeguro: TCheckBox;
    chkPis: TCheckBox;
    chkCofins: TCheckBox;
    chkIpi: TCheckBox;
    chkII: TCheckBox;
    chkAfrmm: TCheckBox;
    chkSiscomex: TCheckBox;
    chkDesAdu: TCheckBox;
    dtsDados: TDataSource;
    chkIOF: TCheckBox;
    chkOutCofins: TCheckBox;
    chkOutPIS: TCheckBox;
    chkOutIOF: TCheckBox;
    chkOutDesAdu: TCheckBox;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure pInicializaIndices; override;
    procedure pLImpar;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetComposicaoValorContabilSet: TComposicaoValorContabilSet;
    function fRetComposicaoValorOutrasSet: TComposicaoValorOutrasSet;
    procedure pDefineCheckBoxValorContabil;
    procedure pDefineCheckBoxValorOutras;
    function fValidaRegras: Boolean;


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadPerfilAduaneiro: TfrmCadPerfilAduaneiro;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadPerfilAduaneiro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  rdgValUnitarProduto.Enabled := (qryTabela.State in dsEditModes);

end;

procedure TfrmCadPerfilAduaneiro.btnCancelaClick(Sender: TObject);
begin
  inherited;
  rdgValUnitarProduto.Enabled := (qryTabela.State in dsEditModes);
end;

procedure TfrmCadPerfilAduaneiro.btnExcluirClick(Sender: TObject);
begin
  inherited;
  rdgValUnitarProduto.Enabled := (qryTabela.State in dsEditModes);
end;

procedure TfrmCadPerfilAduaneiro.btnGravarClick(Sender: TObject);
begin
  If not fValidaRegras then
    Exit;
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  try
    qryTabela.FieldByName('ADU_COMPUN').AsInteger := rdgValUnitarProduto.ItemIndex;
    qryTabela.FieldByName('ADU_COVLCO').AsInteger := TPerfilDespachanteAduaneiro.ComposicaoValorContabilToInt(fRetComposicaoValorContabilSet);
    qryTabela.FieldByName('ADU_COVLOU').AsInteger := TPerfilDespachanteAduaneiro.ComposicaoValorOutrasSetToInt(fRetComposicaoValorOutrasSet);
    inherited;
  except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadPerfilAduaneiro.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
  rdgValUnitarProduto.Enabled := (qryTabela.State in dsEditModes);
  //dbeADU_DECUNI.Enabled := (qryTabela.State in dsEditModes);


end;

procedure TfrmCadPerfilAduaneiro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCODPER, dbeDESPER, False)
  Else
    pHabilitaCodigo(dbeCODPER, dbeCODPER, True);
  rdgValUnitarProduto.Enabled := (qryTabela.State in dsEditModes);
  pLImpar;
//  dbeADU_DECUNI.Enabled := (qryTabela.State in dsEditModes);

//  dbeADU_DECUNI.Value := 4;

end;

procedure TfrmCadPerfilAduaneiro.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  Key   : Char;
begin
  Key := '/';
  If fPesqPerfilAduaneiro(Self, TEditFocus(dbeCODPER), TEditFocus(dbeDESPER), qryTabela, Key, arrSel) then
  Begin
    rdgValUnitarProduto.itemIndex := qryTabela.FieldByName('ADU_COMPUN').AsInteger;
    pDefineCheckBoxValorContabil;
    pDefineCheckBoxValorOutras;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPerfilAduaneiro.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'PERADU';
  qryTabela := fCriaQuery(Self);
  strNomeCampo  := 'ADU_CODPER';
  dtsDados.DataSet := qryTabela;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCODPER;
end;

procedure TfrmCadPerfilAduaneiro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryTabela);
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  inherited;

end;

function TfrmCadPerfilAduaneiro.fRetComposicaoValorContabilSet: TComposicaoValorContabilSet;
begin
  result := [];
  If chkValProduto.Checked then
    result := result + [tcvcVR_PRODUTOS];
  If chkValFre.Checked then
    result := result + [tcvcFRETE];
  If chkIcms.Checked then
    result := result + [tcvcVR_ICMS];
  If chkSeguro.Checked then
    result := result + [tcvcSEGURO];
  If chkPis.Checked then
    result := result + [tcvcPIS];
  If chkCofins.Checked then
    result := result + [tcvcCOFINS];
  If chkIpi.Checked then
    result := result + [tcvcIPI];
  If chkII.Checked then
    result := result + [tcvcII];
  If chkAfrmm.Checked then
    result := result + [tcvcAFRMM];
  If chkSiscomex.Checked then
    result := result + [tcvcSISCOMEX];
  If chkDesAdu.Checked then
    result := result + [tcvcDESPESAS_ADUANEIRAS];
//  If chkOutras.Checked then
//    result := result + [tcvcOUTROS];
  If chkIOF.Checked then
    result := result + [tcvcIOF];

end;

function TfrmCadPerfilAduaneiro.fRetComposicaoValorOutrasSet: TComposicaoValorOutrasSet;
begin
  Result := [];
  If chkOutSiscomex.Checked then
    Result := Result + [tcvoSISCOMEX];
  If chkOutAfrmm.Checked then
    Result := Result + [tcvoAFRMM];
  If chkOutPIS.Checked then
    Result := Result + [tcvoPIS];
  If chkOutCofins.Checked then
    Result := Result + [tcvoCOFINS];
  If chkOutIOF.Checked then
    Result := Result + [tcvoIOF];
  If chkOutDesAdu.Checked then
    Result := Result + [tcvoDESPESAS_ADUANEIRAS];
end;

function TfrmCadPerfilAduaneiro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;

function TfrmCadPerfilAduaneiro.fValidaRegras: Boolean;
begin
  Result := True;
end;

procedure TfrmCadPerfilAduaneiro.pDefineCheckBoxValorContabil;
var ComposicaoValorContabilSet: TComposicaoValorContabilSet;
begin
  ComposicaoValorContabilSet := TPerfilDespachanteAduaneiro.IntToComposicaoValorContabilSet(qryTabela.FieldByName('ADU_COVLCO').AsInteger);
  chkValProduto.Checked := tcvcVR_PRODUTOS in ComposicaoValorContabilSet;
  chkValFre.Checked := tcvcFRETE in ComposicaoValorContabilSet;
  chkIcms.Checked := tcvcVR_ICMS in ComposicaoValorContabilSet;
  chkSeguro.Checked := tcvcSEGURO in ComposicaoValorContabilSet;
  chkPis.Checked := tcvcPIS in ComposicaoValorContabilSet;
  chkCofins.Checked := tcvcCOFINS in ComposicaoValorContabilSet;
  chkIpi.Checked := tcvcIPI in ComposicaoValorContabilSet;
  chkII.Checked := tcvcII in ComposicaoValorContabilSet;
  chkAfrmm.Checked := tcvcAFRMM in ComposicaoValorContabilSet;
  chkSiscomex.Checked := tcvcSISCOMEX in ComposicaoValorContabilSet;
  chkDesAdu.Checked := tcvcDESPESAS_ADUANEIRAS in ComposicaoValorContabilSet;
  //chkOutras.Checked := tcvcOUTROS in ComposicaoValorContabilSet;
  chkIoF.Checked := tcvcIOF in ComposicaoValorContabilSet;
end;

procedure TfrmCadPerfilAduaneiro.pDefineCheckBoxValorOutras;
var ComposicaoValorOutrasSet : TComposicaoValorOutrasSet;
begin
  ComposicaoValorOutrasSet := TPerfilDespachanteAduaneiro.IntToTComposicaoValorOutrasSet(qryTabela.FieldByName('ADU_COVLOU').AsInteger);
  chkOutSiscomex.Checked := tcvoSISCOMEX in ComposicaoValorOutrasSet;
  chkOutAfrmm.Checked := tcvoAFRMM in ComposicaoValorOutrasSet;

  chkOutPIS.Checked := tcvoPIS in ComposicaoValorOutrasSet;
  chkOutCofins.Checked := tcvoCOFINS in ComposicaoValorOutrasSet;
  chkOutIOF.Checked := tcvoIOF in ComposicaoValorOutrasSet;
  chkOutDesAdu.Checked := tcvoDESPESAS_ADUANEIRAS in ComposicaoValorOutrasSet;
end;

procedure TfrmCadPerfilAduaneiro.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('ADU_CODPER');

  stlCamInd.Add('ADU_CODPER');

  stlDesInd.Add('Código');
end;

procedure TfrmCadPerfilAduaneiro.pLImpar;
begin
  chkOutSiscomex.Checked := False;
  chkOutAfrmm.Checked := False;
  chkValProduto.Checked := False;
  chkValFre.Checked := False;
  chkIcms.Checked := False;
  chkSeguro.Checked := False;
  chkPis.Checked := False;
  chkCofins.Checked := False;
  chkIpi.Checked := False;
  chkII.Checked := False;
  chkAfrmm.Checked := False;
  chkSiscomex.Checked := False;
  chkDesAdu.Checked := False;
  chkIOF.Checked := False;
  chkOutCofins.Checked := False;
  chkOutPIS.Checked := False;
  chkOutIOF.Checked := False;
  chkOutDesAdu.Checked := False;
end;

end.

