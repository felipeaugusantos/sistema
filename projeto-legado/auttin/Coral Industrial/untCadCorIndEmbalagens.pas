unit untCadCorIndEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, StrUtils, AppEvnts, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorIndEmbalagens = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodEmb: TDBEditFocus;
    Label2: TLabel;
    dbeQtdEmb: TDBEditFocus;
    Label3: TLabel;
    dbeUnidad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCorIndEmbalagens: TfrmCadCorIndEmbalagens;

implementation

uses untPai, untModuloTinta,
     untConstantes, untFuncoesSimples, untFuncoesConsulta, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadCorIndEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CORIND_CADEMB';
  strNomeCampo  := 'EMB_CODEMB';
  qryTabela     := frmModuloTinta.qryCorInd_CadEmb;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;

End;
procedure TfrmCadCorIndEmbalagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadCorIndEmbalagens.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key := '/';
  fPesqEmbalagens(Self, 'CORIND_CADEMB', dbeCodEmb, dbeQtdEmb, dbeUnidad, qrytabela, key, arrSel);
end;

procedure TfrmCadCorIndEmbalagens.dbeUnidadKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeUnidad, nil, nil, nil, key, arrSel) Then
    If fValidaCampos(dbeUnidad, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndEmbalagens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodEmb.Enabled := False;
  pSetFocus(dbeQtdEmb);
end;

function TfrmCadCorIndEmbalagens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodEmb) Then
  Begin

    If (fEmptyStr(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (fStrToFloat(dbeCodEmb.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser maior que Zero! ', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (blnBuscaPorChave) Then
          fBuscaPorCamposChave;
      End;
    End;

  End

  Else If (Sender = dbeQtdEmb) Then
  Begin

    If (fEmptyStr(dbeQtdEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeQtdEmb.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero! ', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeUnidad) Then
  Begin
    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else
    Begin

      If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
        Result := False;
      End

      Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
        Result := False;
      End;
    End;

  End;

end;

procedure TfrmCadCorIndEmbalagens.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMB_CODEMB');
  stlCampos.Add('EMB_QTDEMB');
  stlCampos.Add('EMB_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMB_CODEMB');
  stlDesInd.Add('Código');
end;

end.

