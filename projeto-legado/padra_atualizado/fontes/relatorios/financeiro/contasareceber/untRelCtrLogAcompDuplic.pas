unit untRelCtrLogAcompDuplic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  untFuncoesSimples, untFuncoesConsulta, untConstantes;

type
  TfrmRelCtrLogAcompDuplic = class(TfrmPaiOrdena)
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtNomCliente: TEditFocus;
    Label1: TLabel;
    Label27: TLabel;
    edtNumDoc: TEditFocus;
    edtParcel: TEditFocus;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtEspecie: TEditFocus;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pFechaConsulta;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;

var
  frmRelCtrLogAcompDuplic: TfrmRelCtrLogAcompDuplic;

implementation

uses untConsultas;

{$R *.dfm}

function TfrmRelCtrLogAcompDuplic.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
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
            End
            Else
            Begin
              stlListSelecao.Clear;
              fAbreConsulta;

              lflLastField.intIndCol := 1;
              lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
              lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
              lflLastField.ftyTipCam := dbgConsulta.Columns[0].Field.DataType;
            End;
          End;
        End
      End;

    End
    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        edtNomCliente.Text := 'TODOS';
      End Else
      Begin
        edtNomCliente.Text := fRetNomCliente(edtCodCliente.Text);
        If fEmptyStr(edtNomCliente.Text) Then
        Begin
          Result := False;
          pMensagemOk('Cliente não encontrado!');
        End;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmRelCtrLogAcompDuplic.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtNomCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrLogAcompDuplic.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrLogAcompDuplic.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

end;

function TfrmRelCtrLogAcompDuplic.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   *      ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   LOGCTR ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDUP ';

  If Not fEmptyStr(edtParcel.Text) Then
    strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL ';

  If Not fEmptyStr(edtEspecie.Text) Then
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

  Result := strSQL;

End;

function TfrmRelCtrLogAcompDuplic.fSetParametros: Boolean;
Begin

  With qryConsulta Do
  Begin

    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtCodCliente.Text) Then
      ParamByName('CODCLI').AsString := edtCodCliente.Text;

    If Not fEmptyStr(edtNumDoc.Text) Then
      ParamByName('NUMDUP').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtParcel.Text) Then
      ParamByName('PARCEL').AsString := edtParcel.Text;

    If Not fEmptyStr(edtEspecie.Text) Then
      ParamByName('ESPDOC').AsString := edtEspecie.Text;

  End;

  Result := True;
End;

procedure TfrmRelCtrLogAcompDuplic.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_ESCAPE: If pnlPesquisa.Visible Or
                 (mskDtaIni.Focused And (Not cdsConsulta.Active)) Then
                 inherited
               Else
                 pFechaConsulta;

    Else       inherited;
  End;

end;

procedure TfrmRelCtrLogAcompDuplic.pFechaConsulta;
Begin
  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtNomCliente.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtNumDoc.Clear;
  edtParcel.Clear;
  edtEspecie.Clear;

  edtNumDoc.SetFocus;
End;

end.
