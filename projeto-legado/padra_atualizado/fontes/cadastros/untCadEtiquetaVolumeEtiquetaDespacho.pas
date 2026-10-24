unit untCadEtiquetaVolumeEtiquetaDespacho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB;

type
  TfrmCadEtiquetaVolumeEtiquetaDespacho = class(TfrmPaiCad)
    pnlPrincipal: TPanel;
    lblDescricao: TLabel;
    lblSigla: TLabel;
    edtDescricao: TDBEditFocus;
    edtSigla: TDBEditFocus;
    dtsEtiqueta: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    function fExisteEtiquetaCadastrada(ASigla: String): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConstantes, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.btnAlterarClick(
  Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(edtSigla, edtDescricao, True);
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.btnExcluirClick(
  Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnGravou Then
    fCommit
  Else
  Begin
    fRollBack;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(edtSigla, edtDescricao, True);
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.btnPesquisaClick(
  Sender: TObject);
var
  chrKey: Char;
  arrEtiq: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqEtiVolDocDespacho(Self, Nil, Nil, qryTabela, chrKey, arrEtiq) Then
    pSetFocus(btnAlterar);
end;

function TfrmCadEtiquetaVolumeEtiquetaDespacho.fExisteEtiquetaCadastrada(
  ASigla: String): Boolean;
var
  LEtiqueta: String;
begin
  LEtiqueta := fCampoTabela('EED_DESCRI','CADEED',['EED_SIGLA_'],[ASigla]);

  Result := Not fEmptyStr(LEtiqueta);
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela       := 'CADEED';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriarQuery('SELECT * FROM CADEED', Self);
  dtsEtiqueta.DataSet := qryTabela;
end;

function TfrmCadEtiquetaVolumeEtiquetaDespacho.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtDescricao) Then
  Begin
    If fEmptyStr(edtDescricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição não pode ficar vazia!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtSigla) Then
  Begin
    If fEmptyStr(edtSigla.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A sigla não pode ficar vazia!', ['&Ok']);
      Result := False;
    End
    Else If fExisteEtiquetaCadastrada(edtSigla.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Etiqueta já cadastrada com esta sigla!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEtiquetaVolumeEtiquetaDespacho.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EED_DESCRI');
  stlCampos.Add('EED_SIGLA_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EED_DESCRI');
  stlCamInd.Add('EED_SIGLA_');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Sigla');
end;

end.
