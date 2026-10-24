{******************************************************************************}
{* "AINDA QUE ERA FILHO, APRENDEU A OBEDIENCIA POR MEIO DAQUILO QUE SOFREU;E, *}
{*  TENDO SIDO APERFEICOADO, VEIO A SER AUTOR DE ETERNA SALVACAO PARA TODOS   *}
{*  OS QUE LHE OBEDECEM." (HEBREUS 5:8-9)                                     *}
{***************************************************************************JC*}

unit untRelEspNotaEntDev;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, Menus,
  QColorLabel, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts, untTypesSistema,
  untEspelhoNotaDevolucao, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untClassPanelCx,untIFuncoes;

type
  TfrmRelEspNotaEntDev = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    Label9: TLabel;
    edtDocumento: TEditFocus;
    Label10: TLabel;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    Label11: TLabel;
    edtDesCliente: TEditFocus;
    edtDesEmpresa: TEditFocus;
    rdgOrdem: TRadioGroup;
    rdgOrdemProd: TRadioGroup;
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objEspNotaDev : TEspNotaDev;

    strCodCli: String;
    strNumDoc: String;
    strEspDoc: String;
    strSerie: String;
    strCndPag: String;
    strDtaEnt: String;
    strDtaDoc: String;
    fltTotCon: Double;
    strDocCon: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEspNotaEntDev: TfrmRelEspNotaEntDev;

implementation

uses untfuncoesFactory, untPai;

{$R *.dfm}

procedure TfrmRelEspNotaEntDev.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEspNotaEntDev.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

procedure TfrmRelEspNotaEntDev.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEspNotaEntDev.FormShow(Sender: TObject);
begin
  edtEspecie.Text    := 'NF';
  edtEspecie.Enabled := True;

  objEspNotaDev := TEspNotaDev.Create(Self);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  edtCodEmpresa.Text := VS_strCodEmp;
  fValidaCampos(edtCodEmpresa, True);

  inherited;

end;

function TfrmRelEspNotaEntDev.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else

    {**************************}
    {* VERIFICA CAMPO EMPRESA *}
    {***********************AF*}
    If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa deve ter um valor!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada no sistema!', ['&O k']);
          Result := False;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else

    If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
        edtDesCliente.Text := 'TODOS'
      Else
        edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

      If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text))  Then
      Begin
        fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEspNotaEntDev.btnImprimirClick(Sender: TObject);
Var
  blnVazia: Boolean;
begin
  blnVazia := True;

  If Not fVerificaCampos Then
    Exit;

  inherited;

  Try
    If blnImprime Then
    Begin

      objEspNotaDev.strDestino     := edtDestino.Text; //3 T
      objEspNotaDev.strTipImpr     := strTipImp;
      objEspNotaDev.strNomImpr     := strNomImp;
      objEspNotaDev.strNomForm     := Self.Name;
      objEspNotaDev.strOrdenar     := ifthen(rdgOrdem.ItemIndex = 0, 'D', 'F'); //3 t
      objEspNotaDev.strOrdenarProd := ifthen(rdgOrdemProd.ItemIndex = 0, 'G', 'D'); //3 t

      blnVazia := objEspNotaDev.fMontaRelEspNotEntDev(mskDtaIni.Text,
                                                      mskDtaFin.Text,
                                                      edtCodEmpresa.Text,
                                                      edtCodCliente.Text,
                                                      edtDocumento.Text,
                                                      edtEspecie.Text,
                                                      edtSerie.Text,
                                                      '',
                                                      '',
                                                      '',
                                                      '');

    End;
  Except
    On E: Exception Do
     Begin
       pMensagensErro(E.Message,'[TfrmRelEspNotaEntDev.btnImprimirClick]');
     End;
  End;
  If Not blnVazia Then
  Begin
    pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEspNotaEntDev.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEspNotaEntDev.FormCreate(Sender: TObject);
begin
  inherited;

  edtDocumento.MaxLength := fTamDocCadRec();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;
end;

procedure TfrmRelEspNotaEntDev.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (ActiveControl Is TRadioButton) Then
    Self.SelectNext(ActiveControl, True, True);
    
end;

end.
