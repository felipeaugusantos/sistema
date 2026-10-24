unit untCadLkdEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, StrUtils, AppEvnts, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Data.DB;

type
  TfrmCadLkdEmbalagens = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeCodEmb: TDBEditFocus;
    Label2: TLabel;
    dbeQtdEmb: TDBEditFocus;
    Label3: TLabel;
    dbeUnidad: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    dtsCadBas: TDataSource;

    procedure pCriaDataSets;
    procedure pLigaDataSets;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadLkdEmbalagens: TfrmCadLkdEmbalagens;

implementation

uses untPai, untModuloTinta,
     untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadLkdEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'LKD_CADEMB';
  strNomeCampo  := 'EMB_CODEMB';
  qryTabela     := frmModuloTinta.qryLkd_CadEmb;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEmb;
End;

procedure TfrmCadLkdEmbalagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  pSetFocus(dbeCodEmb);
end;

procedure TfrmCadLkdEmbalagens.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key:= '/';
  If fPesqEmbalagens(Self, 'LKD_CADEMB', Nil, Nil, Nil, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);

end;

procedure TfrmCadLkdEmbalagens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodEmb.Enabled := False;
  pSetFocus(dbeQtdEmb);
end;

function TfrmCadLkdEmbalagens.fValidaCampos(Sender: TWinControl;
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
    Else If (blnBuscaPorChave) Then
    Begin
      fBuscaPorCamposChave;
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
    End;
  End;

end;

procedure TfrmCadLkdEmbalagens.pCriaDataSets;
begin

  dtsCadBas := fCriaDataSource(frmModuloTinta.qryLkd_CadEmb);

  dtsCadBas.DataSet.FieldByName('EMB_CODEMB').DisplayLabel := 'Código';
  dtsCadBas.DataSet.FieldbyName('EMB_QTDEMB').DisplayLabel := 'Quantidade';
  dtsCadBas.DataSet.FieldbyName('EMB_UNIDAD').DisplayLabel := 'Unidade';
  dtsCadBas.DataSet.FieldByName('AUTOINCREM').Visible := False;

end;

procedure TfrmCadLkdEmbalagens.pLigaDataSets;
  Var
    intCont: Integer;
begin
  {***********************************************************}
  {* LIGA TODOS OS DBEDITS NO DATASOUCE CRIADO DINAMICAMENTE *}
  {********************************************************PH*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End;
  End;
end;


procedure TfrmCadLkdEmbalagens.pInicializaIndices;
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

procedure TfrmCadLkdEmbalagens.dbeUnidadKeyPress(Sender: TObject;  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqUnidade(Self, dbeUnidad, nil, nil, nil, Key, arrSel) then
     SelectNext(ActiveControl, True, True);
end;

end.

