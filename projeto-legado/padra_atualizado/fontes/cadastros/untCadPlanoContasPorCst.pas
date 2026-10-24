unit untCadPlanoContasPorCst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, ComboBoxFocus,
  Data.DB, untTypesSistema, frxClass, frxExportCSVTestabilidade, Vcl.Menus,
  Vcl.ComCtrls, BitBtnLockedIncrem, Uni;

type
  TfrmCadPlanoContasPorCst = class(TfrmPaiCad)
    Panel1: TPanel;
    lbl1: TLabel;
    lblTipo: TLabel;
    Label1: TLabel;
    dtsCstPla: TDataSource;
    pnlCentral: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodCst: TDBEditFocus;
    edtPlanoContabil: TDBEditFocus;
    cmbTipoCst: TComboBoxFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtPlanoContabilKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCstPla: TUniQuery;
    blnUsaPlanco: Boolean;

    function fRetornaPlanoContabil(strPlaCon: string): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadPlanoContasPorCst: TfrmCadPlanoContasPorCst;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes, untFuncoesConsulta,
  Contabilidade.Funcoes;

{$R *.dfm}

function TfrmCadPlanoContasPorCst.fRetornaPlanoContabil(strPlaCon: string): string;
begin
  if blnUsaPlanco then
    Result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['REPLACE(REPLACE(REPLACE(REPLACE(NCO_CODCON, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False)
  else
    Result := fCampoTabela('CON_CODCTA', 'PLACON', ['REPLACE(REPLACE(REPLACE(REPLACE(CON_CODCTA, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False);
end;

function TfrmCadPlanoContasPorCst.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtPlanoContabil) Then
    Begin
      If fEmptyStr(edtPlanoContabil.Text) Then
      Begin
        edtPlanoContabil.Clear;
      End
      Else
      Begin
        If fEmptyStr(fRetornaPlanoContabil(edtPlanoContabil.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano ' + IIF(blnUsaPlanco, '', 'de contas ') + 'contábil inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadPlanoContasPorCst.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCst);
end;

procedure TfrmCadPlanoContasPorCst.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.IsEmpty Then
    cmbTipoCst.ItemIndex := -1
  Else
    cmbTipoCst.ItemIndex := StrToIntDef(qryTabela.FieldByName('PLA_TIPCST').AsString, -1);
end;

procedure TfrmCadPlanoContasPorCst.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    cmbTipoCst.ItemIndex := -1;
  End
  Else
    fRollBack;
end;

procedure TfrmCadPlanoContasPorCst.btnGravarClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('PLA_TIPCST').AsString := IntToStr(cmbTipoCst.ItemIndex);
    qryTabela.FieldByName('PLA_CODEMP').AsString := VS_strCodEmp;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPlanoContasPorCst.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadPlanoContasPorCst.btnIncluirClick(Sender: TObject);
begin
  inherited;
  cmbTipoCst.ItemIndex := -1;
  pSetFocus(edtCodCst);
end;

procedure TfrmCadPlanoContasPorCst.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPlanoContabilCST(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    cmbTipoCst.ItemIndex := StrToIntDef(qryTabela.FieldByName('PLA_TIPCST').AsString, -1);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPlanoContasPorCst.edtPlanoContabilKeyPress(Sender: TObject; var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if blnUsaPlanco then
        begin
          if fPesqPlanoContabil(Self, edtPlanoContabil, nil, nil, Key, arrPlaCon) then
          begin
            If fValidaCampos(edtPlanoContabil, True) Then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end
        else
        begin
          if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
          begin
            edtPlanoContabil.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
            if fValidaCampos(edtPlanoContabil, True) then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadPlanoContasPorCst.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CSTPLA';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CSTPLA';
  qryCstPla         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCstPla;
  dtsCstPla.DataSet := qryTabela;

  blnUsaPlanco := fCfgSpd('USAR_ABREVIACAO_CONTABIL_REG_0500') = 'S';
end;

procedure TfrmCadPlanoContasPorCst.FormDestroy(Sender: TObject);
begin
  stlCampos.Free;
  stlCamInd.Free;
  stlDesInd.Free;

  inherited;
end;

procedure TfrmCadPlanoContasPorCst.FormShow(Sender: TObject);
begin
  inherited;
  cmbTipoCst.ItemIndex := -1;
end;

procedure TfrmCadPlanoContasPorCst.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PLA_CODCST');
  stlCampos.Add('PLA_CONCON');
  stlCampos.Add('PLA_TIPCST');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PLA_CODCST');
  stlDesInd.Add('Cod. Cst');
end;

end.
