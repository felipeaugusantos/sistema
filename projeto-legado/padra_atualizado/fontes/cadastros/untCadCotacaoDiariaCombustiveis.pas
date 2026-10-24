unit untCadCotacaoDiariaCombustiveis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni,
  Vcl.ExtCtrls, untConsultas, untCotacaoDiariaCombustiveis;

type
  TfrmCadCotacaoDiariaCombustiveis = class(TfrmPaiCad)
    dtsCadCmb: TDataSource;
    pnlFundo: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    dbeDtaCot: TDBEditFocus;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeVlrGas: TDBEditFocus;
    dbeVlrEta: TDBEditFocus;
    dbeVlrS10: TDBEditFocus;
    dbeVlrDie: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FObjCotacaoDiariaCombustiveis: TCotacaoDiariaCombustiveis;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmCadCotacaoDiariaCombustiveis }

procedure TfrmCadCotacaoDiariaCombustiveis.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDtaCot);
end;

procedure TfrmCadCotacaoDiariaCombustiveis.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  qryTabela.FieldByName('CMB_CODEMP').AsString := VS_strCodEmp;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCotacaoDiariaCombustiveis.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCotacaoDiariaCombustiveis.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('CMB_DTACOT').AsDateTime := VS_Date;
  pSetFocus(dbeDtaCot);
end;

procedure TfrmCadCotacaoDiariaCombustiveis.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
begin
  chrKey := '/';

  if fPesqCotacaoDiariaCombustiveis(Self, nil, nil, qryTabela, chrKey) then
    if (btnAlterar.Enabled) and (btnAlterar.Visible) then
      pSetFocus(btnAlterar);
end;

procedure TfrmCadCotacaoDiariaCombustiveis.FormCreate(Sender: TObject);
begin
  inherited;
  FObjCotacaoDiariaCombustiveis := TCotacaoDiariaCombustiveis.Create(Self);

  strNomeTabela := 'CADCMB';
  strNomeCampo  := 'CMB_DTACOT';

  qryTabela     := FObjCotacaoDiariaCombustiveis.qryCadCmb;

  dtsCadCmb.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeDtaCot;
end;

procedure TfrmCadCotacaoDiariaCombustiveis.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FObjCotacaoDiariaCombustiveis);
end;

procedure TfrmCadCotacaoDiariaCombustiveis.FormShow(Sender: TObject);
begin
  inherited;
  btnIncluir.Click;
end;

function TfrmCadCotacaoDiariaCombustiveis.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin
    if (Sender = dbeDtaCot) then
    begin
      if fEmptyStr(fTiraCaracEspeciais(dbeDtaCot.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&O k']);
        Result := False;
      end
      else if blnBuscaPorChave then
      begin
        if Not fBuscaPorCamposChave then
          pLimparCampos;
      end;
    end
    else
    if (fEmptyStr(dbeVlrGas.Text) Or (dbeVlrGas.Text = '0') Or (dbeVlrGas.Text = '0,000')) and
       (fEmptyStr(dbeVlrEta.Text) Or (dbeVlrEta.Text = '0') Or (dbeVlrEta.Text = '0,000')) and
       (fEmptyStr(dbeVlrDie.Text) Or (dbeVlrDie.Text = '0') Or (dbeVlrDie.Text = '0,000')) and
       (fEmptyStr(dbeVlrS10.Text) Or (dbeVlrS10.Text = '0') Or (dbeVlrS10.Text = '0,000')) then
    begin
      fMensagem('ATENÇÃO!', 'É preciso preencher o valor de algum combustível!', ['&Ok']);
      Result := False;
    end
  end;

  if Not Result then
    pSetFocus(Sender);
end;

procedure TfrmCadCotacaoDiariaCombustiveis.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CMB_DTACOT');
  stlCamInd.Add('CMB_CODEMP');

  stlDesInd.Add('Data');
  stlDesInd.Add('Empresa');
end;

end.
