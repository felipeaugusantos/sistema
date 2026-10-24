unit untFuncIns2;

interface

uses
  untPai, untPaiCad, Forms, Windows, SysUtils;

  {*****************************************}
  {* USADO NA FUNÇÃO 'fChamaForm'          *}
  {**************************************MV*}

  Type

    TClassPaiCad = class Of TfrmPaiCad;
    TClassPai    = class Of TfrmPai;

  function fChamaCadBai(Key: Word; strCodCid : String): String;
  function fChamaCadOco(Key: Word): String;
  function fChamaCadFor(Key: Word; strCodFor : String = ''): String;
  function fChamaCadCid(Key: Word): String;
  function fChamaCadAti(Key: Word): String;
  function fChamaCadTra(Key: Word): String;
  function fChamaForm(Key: Word; FormClass: TClassPaiCad; Form: TfrmPaiCad): String; Overload;
  function fChamaForm(Key: Word; FormClass: TClassPai   ; Form: TfrmPai   ): String; Overload;
  function fChamaForm(Key: Word; FormClass: TClassPai                     ): String; Overload;
  function fIsInsert(Key: Word): Boolean;

implementation

uses  untCadAtividades, untCadTransportadoras, untFuncoesSimples, untCadCidades, untCadFornecedores,
  untCadOcorrencias, untCadBairros;


function fChamaCadOco(Key: Word): String;
begin
  Result := fChamaForm(Key, TfrmCadOcorrencias);
end;

function fChamaCadBai(Key: Word; strCodCid : String): String;
  var
    frmCadBairros: TfrmCadBairros;
Begin
  Result := '';
  If fIsInsert(Key) Then
  Begin
    Try
      pCriarFormularios(TfrmCadBairros, frmCadBairros);
      frmCadBairros.strCodCid := strCodCid;
      frmCadBairros.showModal;
      Result := frmCadBairros.strUltimoCodigo;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fChamaForm]');
      End;
    End;

    pFreeAndNil(frmCadBairros);
  End;

End;

{*****************************************}
{* CADASTRO DE FORNECEDORES              *}
{**************************************MV*}
function fChamaCadFor(Key: Word; strCodFor : String = ''): String;
begin
  If strCodFor = '' Then
    Result := fChamaForm(Key, TfrmCadFornecedores, frmCadFornecedores)
  Else
  Begin
    result := TfrmCadFornecedores.fCarregaFornecedorExterno(strCodFor);
  End;

end;

{*****************************************}
{* CADASTRO DE CIDADES                   *}
{**************************************MV*}
function fChamaCadCid(Key: Word): String;
begin
  Result := fChamaForm(Key, TfrmCadCidades);
end;

{*****************************************}
{* CADASTRO DE ATIVIDADES                *}
{**************************************MV*}
function fChamaCadAti(Key: Word): String;
begin

  If fVerificaAcessoSistema('frmCadAtividades') Then
    Result := fChamaForm(Key, TfrmCadAtividades)
  Else
    fMensagem('','Sem permissão para Cadastro de Atividades!',['&Ok']);

end;

{*****************************************}
{* CADASTRO DE TRANSPORTADORAS           *}
{**************************************LU*}
function fChamaCadTra(Key: Word): String;
begin
  Result := fChamaForm(Key, TfrmCadTransportadoras);
end;

{****************************************************}
{* NO 'frmPaiCad' HÁ UMA VARIÁVEL 'strUltimoCodigo' *}
{* QUE GUARDA O CÓDIGO DO ÚLTIMO REGISTRO ALTERADO  *}
{* OU GERADO.                                       *}
{*************************************************MV*}
function fChamaForm(Key: Word; FormClass: TClassPaiCad; Form: TfrmPaiCad): String;
begin
  Result := '';
  If fIsInsert(Key) Then
  Begin
    Try
      pCriarFormularios(FormClass, Form);
      Form.showModal;
      Result := Form.strUltimoCodigo;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fChamaForm]');
      End;
    End;

    pFreeAndNil(Form);
  End;

end;

function fChamaForm(Key: Word; FormClass: TClassPai   ; Form: TfrmPai   ): String; Overload;
Begin
  Result := '';
  If fIsInsert(Key) Then
  Begin
    Try
      pCriarFormularios(FormClass, Form);
      Form.showModal;
      Result := Form.strUltimoCodigo;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fChamaForm]');
      End;
    End;

    pFreeAndNil(Form);
  End;

End;

function fChamaForm(Key: Word; FormClass: TClassPai): String; Overload;
 Var
   NomeForm : TfrmPai;
Begin
  Result := '';
  If fIsInsert(Key) Then
  Begin
    Try
      pCriarFormularios(FormClass, NomeForm);
      NomeForm.showModal;
      Result := NomeForm.strUltimoCodigo;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fChamaForm]');
      End;
    End;

    pFreeAndNil(NomeForm);
  End;

End;

function fIsInsert(Key: Word): Boolean;
begin
  Result := Key = VK_Insert;
end;

end.
