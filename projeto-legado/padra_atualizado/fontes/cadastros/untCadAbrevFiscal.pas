{***************************}
{* qryConTrD -> CADTRI(DE) *}
{* qryConTrF -> CADTRI(FE) *}
{************************JB*}

unit untCadAbrevFiscal;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Uni, Menus, EditFocus, AppEvnts;

type
  TfrmCadAbrevFiscal = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeCodAbf: TDBEditFocus;
    dbeDesAbf: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeCustDe: TDBEditFocus;
    dbeCustFe: TDBEditFocus;
    pnlDados: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCustDe: TEditFocus;
    edtCustFe: TEditFocus;
    pnlFundo: TPanel;
    gpbEntrada: TGroupBox;
    Label6: TLabel;
    dbeBaseE07: TDBEditFocus;
    dbeBaseE12: TDBEditFocus;
    dbeBaseE18: TDBEditFocus;
    Label16: TLabel;
    dbeAlqE07: TDBEditFocus;
    dbeAlqE12: TDBEditFocus;
    dbeAlqE18: TDBEditFocus;
    gpbSaida: TGroupBox;
    Label7: TLabel;
    Label15: TLabel;
    dbeAlq_07: TDBEditFocus;
    dbeAlq_12: TDBEditFocus;
    dbeAlq_18: TDBEditFocus;
    dbeBaseS07: TDBEditFocus;
    dbeBaseS12: TDBEditFocus;
    dbeBaseS18: TDBEditFocus;
    gpbMensagens: TGroupBox;
    dbeMen_07: TDBEditFocus;
    dbeMen_12: TDBEditFocus;
    dbeMen_18: TDBEditFocus;
    Label5: TLabel;
    dbeIVAE07: TDBEditFocus;
    dbeIVAE12: TDBEditFocus;
    dbeIVAE18: TDBEditFocus;
    Label8: TLabel;
    dbeIVAS07: TDBEditFocus;
    dbeIVAS12: TDBEditFocus;
    dbeIVAS18: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCustDeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCustFeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function dbeCustDeChamaCadastro(Key: Word): String;
  private
    { Private declarations }
    qryConTrD: TUniQuery;
    qryConTrF: TUniQuery;

    procedure pCarregaSitDe;
    procedure pCarregaSitFe;
    procedure pAtribuiTabelas;

    procedure pLimpaEdits;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadAbrevFiscal: TfrmCadAbrevFiscal;

implementation

uses untModulo, untFuncoes, untfuncoesSimples, untPai, untFuncIns, untPesqAux,
  untModuloCadAbf, untModuloCadTri;

{$R *.dfm}

procedure TfrmCadAbrevFiscal.FormCreate(Sender: TObject);
begin

  inherited;
  strNomeTabela := 'CADABF';
  strNomeCampo  := 'ABF_CODABF';
  qryTabela     := frmModuloCadAbf.qryCadAbf;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodAbf;

end;

function TfrmCadAbrevFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DA ABREVIAÇÃO         *}
    {**************************************MV*}
    If (Sender = dbeCodAbf) Then
    Begin
      If (fEmptyStr(dbeCodAbf.Text)) And (dbeCodAbf.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Abreviação Fiscal deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA ABREVIAÇÃO      *}
    {**************************************MV*}
    Else If (Sender = dbeDesAbf) Then
    Begin
      If fEmptyStr(dbeDesAbf.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Abreviação Fiscal deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO DENTRO DO ESTADO    *}
    {**************************************MV*}
    Else If (Sender = dbeCustDe) Then
    Begin
      If fEmptyStr(dbeCustDe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação Tributaria deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaSitDe;
        If qryConTrD.FieldByName('TRI_CODTRI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Situação Tributaria não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO FORA DO ESTADO      *}
    {**************************************MV*}
    Else If (Sender = dbeCustFe) Then
    Begin
      If fEmptyStr(dbeCustFe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação Tributaria deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaSitFe;
        If qryConTrF.FieldByName('TRI_CODTRI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Situação Tributaria não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
    End

    {*****************************************}
    {* VALIDA A BASE EM 07%, 12% e 18%       *}
    {**************************************MV*}
    Else If (Sender = dbeBaseE07) Or
            (Sender = dbeBaseE12) Or
            (Sender = dbeBaseE18) Or
            (Sender = dbeBaseS07) Or
            (Sender = dbeBaseS12) Or
            (Sender = dbeBaseS18) Then
    Begin
      If fEmptyStr((Sender As TDBEditFocus).Text) Then
      Begin
        (Sender As TDBEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TDBEditFocus).Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Base de ICMS deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAlq_07) Or
            (Sender = dbeAlq_12) Or
            (Sender = dbeAlq_18) Or
            (Sender = dbeAlqE07) Or
            (Sender = dbeAlqE12) Or
            (Sender = dbeAlqE18) Then
    Begin
      If fEmptyStr((Sender As TDBEditFocus).Text) Then
      Begin
        (Sender As TDBEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TDBEditFocus).Text) < 0)   Or
              (fStrToFloat((Sender As TDBEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'Percentual de aliquota inválido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeIVAE07) Or
            (Sender = dbeIVAE12) Or
            (Sender = dbeIVAE18) Or
            (Sender = dbeIVAS07) Or
            (Sender = dbeIVAS12) Or
            (Sender = dbeIVAS18) Then
    Begin
      If fEmptyStr((Sender As TDBEditFocus).Text) Then
      Begin
        (Sender As TDBEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TDBEditFocus).Text) < 0)   Or
              (fStrToFloat((Sender As TDBEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'Percentual de I.V.A. inválido!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmCadAbrevFiscal.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ABF_DESABF');
  stlCampos.Add('ABF_CODABF');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ABF_DESABF');
  stlCamInd.Add('ABF_CODABF');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

  pAtribuiTabelas;
end;

procedure TfrmCadAbrevFiscal.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAbf, dbeDesAbf, False)
  Else
    pHabilitaCodigo(dbeCodAbf, dbeCodAbf, True);
  pLimpaEdits;
end;

procedure TfrmCadAbrevFiscal.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAbf, dbeDesAbf, False);
  pCarregaSitDe;
  pCarregaSitFe;
end;

procedure TfrmCadAbrevFiscal.dbeCustDeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposSit, stlCamIndSit, stlDesIndSit: TStringList;
begin
  inherited;
  stlCamposSit := TStringList.Create;
  stlCamIndSit := TStringList.Create;
  stlDesIndSit := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposSit.Add('TRI_CODTRI');
    stlCamposSit.Add('TRI_DESC01+TRI_DESC02');
    stlCamposSit.Add('AUTOINCREM');

    stlCamIndSit.Add('TRI_CODTRI');
    stlCamIndSit.Add('TRI_DESC01+TRI_DESC02');

    stlDesIndSit.Add('Código');
    stlDesIndSit.Add('Descr. 1 / Descr. 2');

    If pConsultaRapida(Self, qryConTrD, 'CADTRI', stlCamIndSit, stlDesIndSit, stlCamposSit) Then
      dbeCustDe.Text := qryConTrD.FieldByName('TRI_CODTRI').AsString;
    pCarregaSitDe;
  End;

  FreeAndNil(stlCamposSit);
  FreeAndNil(stlCamIndSit);
  FreeAndNil(stlDesIndSit);
end;

procedure TfrmCadAbrevFiscal.dbeCustFeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposSit, stlCamIndSit, stlDesIndSit: TStringList;
begin
  inherited;
  stlCamposSit := TStringList.Create;
  stlCamIndSit := TStringList.Create;
  stlDesIndSit := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposSit.Add('TRI_CODTRI');
    stlCamposSit.Add('TRI_DESC01+TRI_DESC02');
    stlCamposSit.Add('AUTOINCREM');

    stlCamIndSit.Add('TRI_CODTRI');
    stlCamIndSit.Add('TRI_DESC01+TRI_DESC02');

    stlDesIndSit.Add('Código');
    stlDesIndSit.Add('Descr. 1 / Descr. 2');

    If pConsultaRapida(Self, qryConTrF, 'CADTRI', stlCamIndSit, stlDesIndSit, stlCamposSit) Then
      dbeCustFe.Text := qryConTrF.FieldByName('TRI_CODTRI').AsString;
    pCarregaSitFe;
  End;

  FreeAndNil(stlCamposSit);
  FreeAndNil(stlCamIndSit);
  FreeAndNil(stlDesIndSit);
end;

procedure TfrmCadAbrevFiscal.pCarregaSitDe;
begin
  pPesquisaCadTri(frmModuloCadTri.qryCadTri, qryConTrD, dbeCustDe.Text);
  With qryConTrD Do
  Begin
    edtCustDe.Text := FieldByName('TRI_DESC01').AsString;
  End;
end;

procedure TfrmCadAbrevFiscal.pCarregaSitFe;
begin
  pPesquisaCadTri(frmModuloCadTri.qryCadTri, qryConTrF, dbeCustFe.Text);
  With qryConTrF Do
  Begin
    edtCustFe.Text := FieldByName('TRI_DESC01').AsString;
  End;
end;

procedure TfrmCadAbrevFiscal.pLimpaEdits;
begin
  edtCustDe.Clear;
  edtCustFe.Clear;
end;

procedure TfrmCadAbrevFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaSitDe;
  pCarregaSitFe;
end;

procedure TfrmCadAbrevFiscal.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaSitDe;
  pCarregaSitFe;
end;

procedure TfrmCadAbrevFiscal.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pCarregaSitDe;
  pCarregaSitFe;
end;

procedure TfrmCadAbrevFiscal.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaSitDe;
  pCarregaSitFe;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadAbrevFiscal.dbeCustDeChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadTri(Key);
end;

procedure TfrmCadAbrevFiscal.pAtribuiTabelas;
begin
  qryConTrD := frmModuloCadTri.qryCadTri;
  qryConTrF := frmModuloCadTri.qryCadTri;
end;

end.

