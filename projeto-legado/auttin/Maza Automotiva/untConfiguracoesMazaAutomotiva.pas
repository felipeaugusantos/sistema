unit untConfiguracoesMazaAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, Uni, StrUtils, ComCtrls,
  untIConsultaTinta, untIConfTinta, untConfConsulta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesMazaAutomotiva = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    lblPath: TLabel;
    lblTrava: TLabel;
    lblFator: TLabel;
    lblProximoCodigo: TLabel;
    grpProdutos: TGroupBox;
    lblLitro: TLabel;
    lblGalao: TLabel;
    lblCopo: TLabel;
    lblSpray: TLabel;
    edtLitro: TEditFocus;
    edtDesLitro: TEditFocus;
    edtDesGalao: TEditFocus;
    edtGalao: TEditFocus;
    edtDesCopo: TEditFocus;
    edtCopo: TEditFocus;
    edtDesSpray: TEditFocus;
    edtSpray: TEditFocus;
    chkUsaTin: TCheckBox;
    edtCampoTrava: TEditFocus;
    edtFator: TEditFocus;
    edtProCodNfm: TEditFocus;
    grpProdVen: TGroupBox;
    edtProMza: TEditFocus;
    edtProMzaVen: TEditFocus;
    chkUsaFor: TCheckBox;
    btnConfirma: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label50: TLabel;
    edtApreve: TEditFocus;
    edtPath: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtLitroKeyPress(Sender: TObject; var Key: Char);
    procedure edtGalaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCopoKeyPress(Sender: TObject; var Key: Char);
    procedure edtSprayKeyPress(Sender: TObject; var Key: Char);
    procedure edtProMzaKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    { Private declarations }

    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaMazaAutomotiva: TfrmConfConsulta;

    procedure pCarregarConfiguracoes;
    procedure pSalvarConfiguracoes;
    procedure pCarregarIte(edtCodIte, edtDesIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesMazaAutomotiva: TfrmConfiguracoesMazaAutomotiva;

implementation

uses untFuncTinta, untFuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesMazaAutomotiva }

procedure TfrmConfiguracoesMazaAutomotiva.pCarregarConfiguracoes;
begin

  edtLitro.Text := conf.fGet('MZALIT'); 
  edtGalao.Text := conf.fGet('MZAGAL');
  edtCopo.Text  := conf.fGet('MZACOP');
  edtSpray.Text := conf.fGet('MZASPR');

  edtPath.Text       := conf.fGet('MZAPAT');
  edtCampoTrava.Text := conf.fGet('MZATRV');
  edtFator.Text      := conf.fGet('MZAFAT');
  edtProCodNfm.Text  := conf.fGet('MZANFM');
  edtProMza.Text     := conf.fGet('MZAPRO');

  chkUsaTin.Checked  := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked  := conf.fGetBoolean('USAFOR');

  edtDesOpe.Text      := conf.fGet('DESOPE');
  edtApreve.Text      := conf.fGet('APREVE');

  pCarregarIte(edtLitro, edtDesLitro);
  pCarregarIte(edtGalao, edtDesGalao);
  pCarregarIte(edtCopo, edtDesCopo);
  pCarregarIte(edtSpray, edtDesSpray);
  pCarregarIte(edtProMza, edtProMzaVen);

end;

procedure TfrmConfiguracoesMazaAutomotiva.pSalvarConfiguracoes;
begin

  conf.pSet('MZALIT', edtLitro.Text); 
  conf.pSet('MZAGAL', edtGalao.Text); 
  conf.pSet('MZACOP', edtCopo.Text);
  conf.pSet('MZASPR', edtSpray.Text);

  conf.pSet('MZAPAT', edtPath.Text);  
  conf.pSet('MZATRV', edtCampoTrava.Text);  
  conf.pSet('MZAFAT', edtFator.Text);
  conf.pSet('MZANFM', edtProCodNfm.Text);  

  conf.pSetBoolean('USATIN', chkUsaTin.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked); 

  conf.pSet('MZAPRO', edtProMza.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));



  frmConfConsultaMazaAutomotiva.pSalvarConfs;
end;

procedure TfrmConfiguracoesMazaAutomotiva.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('MZA');
  conf     := fGetConfTinta('MZA');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'USATIN', 'N'));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'USAFOR', 'N'));

  conf.pInsereCodigo('MZALIT', 'Item embalagem Litro', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZALIT', ''));
  conf.pInsereCodigo('MZAGAL', 'Item embalagem Galão', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZAGAL', ''));
  conf.pInsereCodigo('MZACOP', 'Item embalagem Copo', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZACOP', ''));
  conf.pInsereCodigo('MZASPR', 'Item embalagem Spray', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZASPR', ''));
  conf.pInsereCodigo('MZAPAT', 'Path', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZAPAT', ''));
  conf.pInsereCodigo('MZATRV', 'Trava valor de Venda MZA_PRE', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZATRV', ''));
  conf.pInsereCodigo('MZAFAT', 'Fator', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZAFAT', ''));
  conf.pInsereCodigo('MZANFM', 'Próximo Código Novas Fórmulas', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZANFM', ''));
  conf.pInsereCodigo('MZAPRO', 'Produto para Venda', fArqIniTinta(0, 'MAZA AUTOMOTIVA', 'MZAPRO', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfiguracoes;
  frmConfConsultaMazaAutomotiva := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;

  edtPath.Dialog.Dialog.Filter := 'All files (*.txt)|*.txt';
end;

procedure TfrmConfiguracoesMazaAutomotiva.btnConfirmaClick(
  Sender: TObject);
begin
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pSalvarConfiguracoes;
      Close;
    End;
  End;
end;

function TfrmConfiguracoesMazaAutomotiva.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtPath Then
    Begin
      If Not fEmptyStr(edtPath.Text) Then
      Begin
        If Not FileExists(edtPath.Text) Then
        Begin
          Result :=  fMensagem('ATENÇÃO', 'O path especificado não é válido!', ['OK']) = -1;
        End;
      End;
    End
    Else If Sender = edtCampoTrava Then
    Begin
      If fEmptyStr(edtCampoTrava.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Campo trava deve ser preenchido!', ['OK']) = -1;
      End
      Else If Pos(edtCampoTrava.Text, '_CUS_VEN_') = 0 Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O campo deve ser CUS ou VEN', ['OK']) = -1;
      End;
    End
    Else If Sender = edtFator Then
    Begin
      If fEmptyStr(edtFator.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Fator da trava deve ser preenchido!', ['OK']) = -1;
      End
      Else If fStrToFloat(edtFator.Text) <= 0 Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtProCodNfm Then
    Begin
      If fEmptyStr(edtProCodNfm.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Próximo código deve ser preenchido!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtLitro Then
    Begin
      pCarregarIte(edtLitro, edtDesLitro);

      If fEmptyStr(edtDesLitro.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End
    End
    Else If Sender = edtGalao Then
    Begin
      pCarregarIte(edtGalao, edtDesGalao);

      If fEmptyStr(edtDesGalao.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtCopo Then
    Begin
      pCarregarIte(edtCopo, edtDesCopo);

      If fEmptyStr(edtDesCopo.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtSpray Then
    Begin
      pCarregarIte(edtSpray, edtDesSpray);

      If fEmptyStr(edtDesSpray.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End

    Else If Sender = edtProMza Then
    Begin
      pCarregarIte(edtProMza, edtProMzaVen);

      If fEmptyStr(edtProMza.Text) Then
        Result := fMensagem('ATENÇÃO', 'O produto para vende deve ser associado!', ['OK']) = -1
      Else If fEmptyStr(edtProMzaVen.Text) Then
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
    End

    Else If (Sender = edtDesOpe) Then
    begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesMazaAutomotiva.pCarregarIte(edtCodIte,
  edtDesIte: TEdit);
  Var
    qryMza: TUniQuery;
begin
  qryMza := fCriaQuery();
  qryMza.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryMza.ParamByName('CODITE').AsString := edtCodIte.Text;
  qryMza.Open;

  edtDesIte.Text := qryMza.FieldbyName('ITE_DESITE').AsString;
  FreeAndNil(qryMza);
end;

procedure TfrmConfiguracoesMazaAutomotiva.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesMazaAutomotiva.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesMazaAutomotiva.edtLitroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtLitro, edtDesLitro);
  End;
end;

procedure TfrmConfiguracoesMazaAutomotiva.edtGalaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtGalao, edtDesGalao);
  End;
end;

procedure TfrmConfiguracoesMazaAutomotiva.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaMazaAutomotiva.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesMazaAutomotiva.Destroy;
begin
  if Assigned(frmConfConsultaMazaAutomotiva) then FreeAndNil(frmConfConsultaMazaAutomotiva);
  inherited;
end;

procedure TfrmConfiguracoesMazaAutomotiva.edtCopoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtCopo, edtDesCopo);
  End;
end;

procedure TfrmConfiguracoesMazaAutomotiva.edtSprayKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtSpray, edtDesSpray);
  End;
end;

procedure TfrmConfiguracoesMazaAutomotiva.edtProMzaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtProMza, edtProMzaVen);
  End;
end;

end.
