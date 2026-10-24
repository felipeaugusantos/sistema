unit untCadConcorrencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, untCadConcorr, Data.DB;

type
  TfrmCadConcorrencia = class(TfrmPaiCad)
    pnlGeral: TPanel;
    lblCodConcorrencia: TLabel;
    edtCodConcorrencia: TDBEditFocus;
    lblDesConcorrencia: TLabel;
    edtDesConcorrencia: TDBEditFocus;
    dtsConcorrencia: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objCadConcorrencia: TCadConcorr;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadConcorrencia }

procedure TfrmCadConcorrencia.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtCodConcorrencia.Enabled := False;
  pSetFocus(edtDesConcorrencia);
end;

procedure TfrmCadConcorrencia.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConcorrencia.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadConcorrencia.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConcorrencia.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadConcorrencia.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if (blnUsaProCodigo) then
  begin
    pHabilitaCodigo(edtCodConcorrencia, edtDesConcorrencia, False);
  end
  else
  begin
    pHabilitaCodigo(edtCodConcorrencia, edtCodConcorrencia, True);
  end;
end;

procedure TfrmCadConcorrencia.btnPesquisaClick(Sender: TObject);
var
  chrKey   : Char;
  arrCodCnr: TConsultasArray;
begin
  chrKey := '/';

  if fPesqConcorrencia(Self, Nil, Nil, qryTabela, chrKey, arrCodCnr) then
  begin
    if (btnAlterar.Enabled) and (btnAlterar.Visible) then
    begin
      pSetFocus(btnAlterar);
    end;
  end;
end;

procedure TfrmCadConcorrencia.FormCreate(Sender: TObject);
begin
  objCadConcorrencia      := TCadConcorr.Create(Self);

  inherited;

  strNomeTabela           := 'CADCNR';
  strNomeCampo            := 'CNR_CODCON';
  qryTabela               := objCadConcorrencia.qryTabela;
  dtsConcorrencia.DataSet := qryTabela;
end;

function TfrmCadConcorrencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin
    try
      if (Sender = edtCodConcorrencia) then
      begin
        if (edtCodConcorrencia.Enabled) then
        begin
          objCadConcorrencia.strCodCon := edtCodConcorrencia.Text;
        end;

        if (blnBuscaPorChave) then
        begin
          if blnBuscaPorChave then
          begin
            pLimparCampos;
          end
          else
          begin
            edtCodConcorrencia.Enabled := False;
            if (edtDesConcorrencia.Enabled) then
            begin
              pSetFocus(edtDesConcorrencia);
              blnMudarFoco := False;
            end;
          end;
        end;
      end
      else if (Sender = edtDesConcorrencia) then
      begin
        if (fEmptyStr(edtDesConcorrencia.Text)) then
        begin
          fMensagem('ATENÇÃO', 'A descrição da concorrência deve ser preenchido!', ['&OK']);
          Result := False;
        end
        else
        begin
          objCadConcorrencia.strDesCon := edtDesConcorrencia.Text;
        end;
      end;
    except
      on E: Exception do
      begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      end;
    end;
  end;

  if (not Result) then
  begin
    pSetFocus(Sender);
  end;
end;

procedure TfrmCadConcorrencia.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CNR_DESCON');
  stlCampos.Add('CNR_DESCON');

  stlCamInd.Add('CNR_CODCON');
  stlCamInd.Add('CNR_DESCON');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
