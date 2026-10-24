unit untCategoriaOrcamentoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, QColorLabel;

type
  TfrmCategoriaOrcamentoPedido = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label34: TLabel;
    dbeCorCat: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label8: TLabel;
    dbeEspOrc: TDBEditFocus;
    Label3: TLabel;
    dbeEspPed: TDBEditFocus;
    ColorLabel2: TColorLabel;
    ColorLabel1: TColorLabel;
    cldCores: TColorDialog;
    pnlLead: TPanel;
    ColorLabel3: TColorLabel;
    Label4: TLabel;
    dbeLead: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure Label34Click(Sender: TObject);
    procedure dbeCorCatChange(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untCategoriaCadLead;

{$R *.dfm}

procedure TfrmCategoriaOrcamentoPedido.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCategoriaOrcamentoPedido.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCategoriaOrcamentoPedido.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCategoriaOrcamentoPedido.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCategoriaOrcamentoPedido.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.Active) And (qryTabela.State in [dsInsert]) Then
  Begin

    qryTabela.FieldByName('CAT_ESPORC').AsString := 'S';
    qryTabela.FieldByName('CAT_ESPPED').AsString := 'S';
    qryTabela.FieldByName('CAT_LEDPER').AsString := TCategoriaCadLead.VALOR_PADRAO_FLAG_LEAD;

    If dbeDescri.CanFocus Then
      pSetFocus(dbeDescri);
  End;
end;

procedure TfrmCategoriaOrcamentoPedido.btnPesquisaClick(Sender: TObject);
var
  chrKey        : Char;
  arrCategorias : TConsultasArray;
begin

  chrKey := '/';
  if fPesqCategoriaOrPd(Self, Nil, Nil, qryTabela, chrKey, arrCategorias, True, '', False) then
  begin
    pSetFocus(btnAlterar);
  end;

end;

procedure TfrmCategoriaOrcamentoPedido.dbeCorCatChange(Sender: TObject);
Var
  strColor : String;
begin
  inherited;

  Try

    If qryTabela.IsEmpty Then
      Exit;

    If TDBEditFocus(Sender).Field = Nil Then
      Exit;

    strColor := TDBEditFocus(Sender).Field.AsString;

    If not fEmptyStr(strColor) Then
    Begin
      TDBEditFocus(Sender).Color       := StrToIntDef(strColor,0);
      TDBEditFocus(Sender).NormalColor := StrToIntDef(strColor,0);
      TDBEditFocus(Sender).FocusColor  := StrToIntDef(strColor,0);
      TDBEditFocus(Sender).Font.Color  := StrToIntDef(strColor,0);
    End
    Else
    Begin
      TDBEditFocus(Sender).Color       := clWindow;
      TDBEditFocus(Sender).NormalColor := clWindow;
      TDBEditFocus(Sender).FocusColor  := clWindow;
      TDBEditFocus(Sender).Font.Color  := clBlack;
    End;

  except

  End;

end;

procedure TfrmCategoriaOrcamentoPedido.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = dbeCorCat.Field then
    dbeCorCatChange(dbeCorCat);
end;

procedure TfrmCategoriaOrcamentoPedido.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CATEGO';
  strNomeCampo  := 'CAT_CODIGO';
  qryTabela     := fCriarQuery('SELECT * FROM CATEGO WHERE FALSE', Self);
  dtsTabela.DataSet := qryTabela;

  blnUsaProCodigo := True;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCategoriaOrcamentoPedido.FormShow(Sender: TObject);
  var
    objCategoriaCadLead: TCategoriaCadLead;
begin
  inherited;

  objCategoriaCadLead:=  TCategoriaCadLead.Create;
  Try

    objCategoriaCadLead.blnUleads:= fCfgSis('ULEADS', varBoolean);

    pnlLead.Visible    := objCategoriaCadLead.fExibeCategoriaNaTelaCadastro;

  Finally
    FreeAndNil(objCategoriaCadLead);
  End;
end;

function TfrmCategoriaOrcamentoPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeEspOrc) Then
    Begin
      If Pos(dbeEspOrc.Text,'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo (Orçamento) deve ser S ou N!', ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = dbeEspPed) Then
    Begin
      If Pos(dbeEspPed.Text,'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo (Pedido) deve ser S ou N!', ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo (Descrição) deve ser informado!', ['&Ok']);
        Result := False;
      End
    End
    Else If (Sender = dbeCorCat) Then
    Begin
      If fEmptyStr(dbeCorCat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo (Cor) deve ser informado!', ['&Ok']);
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCategoriaOrcamentoPedido.Label34Click(Sender: TObject);
begin

  inherited;

  if not (qryTabela.State in dsEditModes) then
    Exit;

  cldCores.Color := StrToIntDef(TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString,0);

  If (cldCores.Execute) Then
    TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString := IntToStr(cldCores.Color);

end;

procedure TfrmCategoriaOrcamentoPedido.pInicializaIndices;
begin

  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CAT_CODIGO');
  stlCampos.Add('CAT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CAT_CODIGO');
  stlCamInd.Add('CAT_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');

end;


end.
