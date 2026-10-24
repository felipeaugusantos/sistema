unit untTEditFocusExtendPesCte;

interface

  uses Forms, SysUtils, EditFocus, Winapi.Messages,Winapi.Windows, Vcl.Controls, System.Classes, Vcl.Graphics, System.UITypes,
       Uni, untTypePesCte, untTypesSistema, untConsultas;

  type
    TTipoCampoIdentificado = (tciCNPJ, tcirazaoSocial, tciIE, tciUF, tciLogradouro, tciNumero, tciBairro,tciCEP, tciMunicipio, tciCodigoMunicipio, tciCodigoIBGE);
    TConsultaCGC_Tipo = (tcctFornecedor, tcctCliente);
    TPessoaEditKeyDown = procedure (Sender: TObject; var Key: Word; Shift: TShiftState) of Object;
    TEditFocus = class(EditFocus.TEditFocus)
    private
      FQryDados: TUniQuery;
      procedure pConsultaCadastroCliente(var Key: Char);
      procedure pConsultaCadastroFornecedor(var Key: Char);
      procedure pConsultaCadastroEmpresa(var Key: Char);
      procedure pCarregaDadosFornecedor;
      procedure pCarregaDadosCliente;
      procedure pCarregaDadosEmpresa;
      procedure pCarregadados;
      procedure pPreencheDependentes(qry: TUniQuery);
    protected
      strOldValue: String;
      strNewValue: String;
      procedure KeyPress(var Key: Char); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState);override;

      procedure DoExit; override;
      procedure DoEnter; override;
      function fGetConteudo(ATipoCampoIdentificado: TTipoCampoIdentificado; qry: TUniQuery): string;
      procedure pSetValueEdit(WinControl: TControl; recPessoa: TPessoaCTE);
      procedure pLimpaTodosOsCampos;
      function fRetCGC(ConsultaCGC_Tipo: TConsultaCGC_Tipo; ACodigo: String): String;
      function fRetTipCad: String;
      function fRetDescricaoPessoa: String;
      procedure pCarregaCamposTomador;

    public
      TipoPessoa: TTipoPessoa;
      TipoDocumento: TTipoDocumentoAnexoCTE;
      TipoCampoIdentificado: TTipoCampoIdentificado;
      Agrupador: TWinControl;
      AgrupadorTomador: TWinControl;
      Tomador: integer;
      Principal: Boolean;
      FormPai: TForm;
      PessoaEditKeyDown: TPessoaEditKeyDown;
      procedure pSetPessoa(recPessoa: TPessoaCTE);
      function fRetPessoa(intTomador: integer; intTipoDocumento: integer): TPessoaCTE;
      constructor Create(AOwner: TComponent); override;
      procedure pSalva(ASeqCdFis: String; intTomador: integer);
      procedure pPreenchido;
      procedure pLimpaGrupo;
  End;




implementation

uses
  untFuncoesSimples, untFuncIns;

{ TEditFocus }

constructor TEditFocus.Create(AOwner: TComponent);
begin
  inherited;
  Principal := False;
end;

procedure TEditFocus.DoEnter;
begin
  inherited;
  strOldValue := Text;
end;

procedure TEditFocus.DoExit;
Begin
  If Text <> '' then
  Begin
    strNewValue := Text;
    If strNewValue = strOldValue Then
      Exit;


    case TipoPessoa of
      tpessRemetente: Begin
                        case TipoDocumento of
                          tdNotaCompra: pCarregaDadosFornecedor;
                          tdNotaVenda: pCarregaDadosEmpresa;
                          tdNotaDevolucaoVenda: pCarregaDadosCliente;
                          tdNotaDevolucaoCompra: pCarregaDadosEmpresa;
                        End;
                      End;
      tpessEmitente: Begin
                       case TipoDocumento of
                         tdNotaCompra: pCarregaDadosFornecedor;
                         tdNotaVenda: pCarregaDadosFornecedor;
                         tdNotaDevolucaoVenda: pCarregaDadosFornecedor;
                         tdNotaDevolucaoCompra: pCarregaDadosFornecedor;
                       End;
                     End;
      tpessDestinatario: Begin
                           case TipoDocumento of
                             tdNotaCompra: pCarregaDadosEmpresa;
                             tdNotaVenda: pCarregaDadosCliente;
                             tdNotaDevolucaoVenda: pCarregaDadosEmpresa;
                             tdNotaDevolucaoCompra: pCarregaDadosFornecedor;
                           End;
                         End;
      tpessTomador : pCarregaDadosEmpresa;
      tpessExpedidor: pCarregaDadosCliente;
      tpessRecebedor: pCarregaDadosEmpresa;
    End;
    If Text = '' Then
      pMensagemOk('Atenção! O CNPJ/CPF não foi encontrado no cadastro de '+fRetTipCad+'.')
    Else
      pCarregaCamposTomador;
  End
  Else
    pLimpaTodosOsCampos;
  inherited;

end;

function TEditFocus.fGetConteudo(ATipoCampoIdentificado: TTipoCampoIdentificado; qry: TUniQuery): string;
begin
  case ATipoCampoIdentificado  of
    tciCNPJ           : Result := qry.FieldByName('CNPJ').AsString;
    tcirazaoSocial    : Result := qry.FieldByName('NOME').AsString;
    tciIE             : Result := qry.FieldByName('IE').AsString;
    tciUF             : Result := qry.FieldByName('ESTADO').AsString;
    tciLogradouro     : Result := qry.FieldByName('ENDERE').AsString;
    tciNumero         : Result := qry.FieldByName('ENDNUM').AsString;
    tciBairro         : Result := qry.FieldByName('BAIRRO').AsString;
    tciCEP            : Result := qry.FieldByName('CEP').AsString;
    tciMunicipio      : Result := qry.FieldByName('NOMCID').AsString;
    tciCodigoMunicipio: Result := qry.FieldByName('CORREIO').AsString;
    tciCodigoIBGE     : Result := qry.FieldByName('IBGE').AsString;
  End;
end;

function TEditFocus.fRetCGC(ConsultaCGC_Tipo: TConsultaCGC_Tipo;
  ACodigo: String): String;
begin
  If ACodigo = '' Then
    Exit('');


  case ConsultaCGC_Tipo of
    tcctFornecedor : Result := fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [ACodigo]);
    tcctCliente    : Result := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [ACodigo]);
  Else
    Result := '';
  End;
end;

function TEditFocus.fRetDescricaoPessoa: String;
begin
  Result := '';
  case TipoPessoa of
    tpessRemetente: Result := 'REMETENTE';
    tpessEmitente: Result := 'EMITENTE';
    tpessDestinatario: Result := 'DESTINATARIO';
    tpessTomador : Result := 'TOMADOR';
    tpessExpedidor: Result := 'EXPEDIDOR';
    tpessRecebedor: Result := 'RECEBEDOR';
  end;

end;

function TEditFocus.fRetPessoa(intTomador: integer; intTipoDocumento: Integer): TPessoaCTE;
var i: integer;
begin
  inherited;
  For i := 0 To Agrupador.ControlCount -1 Do
  Begin
    If Agrupador.Controls[i] is TEditFocus Then
    begin
      case TEditFocus(Agrupador.Controls[i]).TipoCampoIdentificado of
        tciCNPJ           : Result.strCNPJ := TEditFocus(Agrupador.Controls[i]).Text;
        tcirazaoSocial    : Result.strRAZAO_SOCIAL := TEditFocus(Agrupador.Controls[i]).Text;
        tciIE             : Result.strINSCRICAO_ESTADUAL := TEditFocus(Agrupador.Controls[i]).Text;
        tciUF             : Result.strUF := TEditFocus(Agrupador.Controls[i]).Text;
        tciLogradouro     : Result.xLgr := TEditFocus(Agrupador.Controls[i]).Text;
        tciNumero         : Result.xNro := TEditFocus(Agrupador.Controls[i]).Text;
        tciBairro         : Result.xBairro := TEditFocus(Agrupador.Controls[i]).Text;
        tciCEP            : Result.strCEP := TEditFocus(Agrupador.Controls[i]).Text;
        tciMunicipio      : Result.xMun:= TEditFocus(Agrupador.Controls[i]).Text;
        tciCodigoMunicipio: Result.cMun := TEditFocus(Agrupador.Controls[i]).Text;
        tciCodigoIBGE     : Result.strCODIBGE := TEditFocus(Agrupador.Controls[i]).Text;
      End;
    End;
  End;
  Result.intCodTomador := intTomador;
  Result.intTipoDocumento := intTipoDocumento;


end;

function TEditFocus.fRetTipCad: String;
begin
  case TipoPessoa of
    tpessRemetente: Begin
                      case TipoDocumento of
                        tdNotaCompra: Result := 'Fornecedor';
                        tdNotaVenda: Result := 'Empresa';
                        tdNotaDevolucaoVenda: Result := 'Cliente';
                        tdNotaDevolucaoCompra: Result := 'Empresa';
                      End;
                    End;
    tpessEmitente: Begin
                     case TipoDocumento of
                       tdNotaCompra: Result := 'Fornecedor';
                       tdNotaVenda: Result := 'Fornecedor';
                       tdNotaDevolucaoVenda: Result := 'Fornecedor';
                       tdNotaDevolucaoCompra: Result := 'Fornecedor';
                     End;
                   End;
    tpessDestinatario: Begin
                         case TipoDocumento of
                           tdNotaCompra: Result := 'Empresa';
                           tdNotaVenda : Result := 'Cliente';
                           tdNotaDevolucaoVenda: Result := 'Empresa';
                           tdNotaDevolucaoCompra: Result := 'Fornecedor';
                         End;
                       End;
    tpessTomador : Result := 'Empresa';
    tpessExpedidor : Result := 'Cliente';
    tpessRecebedor: Result := 'Empresa';
  End;
end;

procedure TEditFocus.pSalva(ASeqCdFis: String; intTomador: integer);
var qryComand: TUniQuery;
    recPessoa: TPessoaCTE;
begin
  If Text <> '' Then
  begin
    qryComand := fCriaQuery;
    Try
      recPessoa := fRetPessoa(intTomador, -1);
      qryComand.SQL.Clear;
      qryComand.SQL.Add('INSERT INTO PESCTE(');
      qryComand.SQL.Add('CTE_CODTOM,');
      qryComand.SQL.Add('CTE_TIPPES,');
      qryComand.SQL.Add('CTE_SEQCTE,');
      qryComand.SQL.Add('AUTOINCREM,');
      qryComand.SQL.Add('CTE_C_G_C_,');
      qryComand.SQL.Add('CTE_I_E_S_,');
      qryComand.SQL.Add('CTE_RAZSOC,');
      qryComand.SQL.Add('CTE_UNIFED,');
      qryComand.SQL.Add('CTE_DESMUN,');
      qryComand.SQL.Add('CTE_C_E_P_,');
      qryComand.SQL.Add('CTE_DIGMAN,');
      qryComand.SQL.Add('CTE_CODMUN,');
      qryComand.SQL.Add('CTE_CDIBGE) VALUES (');
      qryComand.SQL.Add(':CODTOM,');
      qryComand.SQL.Add(':TIPPES,');
      qryComand.SQL.Add(':SEQCTE,');
      qryComand.SQL.Add(':SEQUEN,');
      qryComand.SQL.Add(':C_G_C_,');
      qryComand.SQL.Add(':I_E_S_,');
      qryComand.SQL.Add(':RAZSOC,');
      qryComand.SQL.Add(':UNIFED,');
      qryComand.SQL.Add(':DESMUN,');
      qryComand.SQL.Add(':C_E_P_,');
      qryComand.SQL.Add(':DIGMAN,');
      qryComand.SQL.Add(':CODMUN,');
      qryComand.SQL.Add(':CDIBGE )');

      qryComand.ParamByName('CODTOM').AsInteger := recPessoa.intCodTomador;
      qryComand.ParamByName('SEQCTE').AsString  := ASeqCdFis;
      qryComand.ParamByName('TIPPES').AsString  := fRetDescricaoPessoa;
      qryComand.ParamByName('SEQUEN').AsString  := fRetAutoIncrem('PESCTE', VS_strCodEmp);
      qryComand.ParamByName('C_G_C_').AsString  := String(recPessoa.strCNPJ);
      qryComand.ParamByName('I_E_S_').AsString  := String(recPessoa.strINSCRICAO_ESTADUAL);
      qryComand.ParamByName('RAZSOC').AsString  := String(recPessoa.strRAZAO_SOCIAL);
      qryComand.ParamByName('UNIFED').AsString  := String(recPessoa.strUF);
      qryComand.ParamByName('DESMUN').AsString  := String(recPessoa.xMun);
      qryComand.ParamByName('CODMUN').AsString  := String(recPessoa.cMun);
      qryComand.ParamByName('C_E_P_').AsString  := String(recPessoa.strCEP);
      qryComand.ParamByName('DIGMAN').AsInteger := 1;
      qryComand.ParamByName('CDIBGE').AsString  := String(recPessoa.strCODIBGE);
      qryComand.ExecSQL;
    Finally
      FreeAndNil(qryComand)
    End;
  End;
end;

procedure TEditFocus.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  Case Key of
    VK_INSERT : begin
                  case TipoPessoa of
                    tpessRemetente: Begin
                                      case TipoDocumento of
                                        tdNotaCompra: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                        tdNotaDevolucaoVenda: Self.text := fRetCGC(tcctCliente, fChamaCadCli(Key));
                                      End;
                                    End;
                    tpessEmitente: Begin
                                     case TipoDocumento of
                                       tdNotaCompra: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                       tdNotaVenda: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                       tdNotaDevolucaoVenda: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                       tdNotaDevolucaoCompra: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                     End;
                                   End;
                    tpessDestinatario: Case tipoDocumento Of
                                         tdNotaVenda: fRetCGC(tcctCliente,fChamaCadCli(Key));
                                         tdNotaDevolucaoCompra: Self.text := fRetCGC(tcctFornecedor, fChamaCadFor(Key));
                                       End;
                    tpessExpedidor: Self.text := fRetCGC(tcctCliente,fChamaCadCli(Key));
                  End;
                End;
    VK_RETURN : Begin
                  If Assigned(PessoaEditKeyDown) then
                    PessoaEditKeyDown(Self, Key, Shift);
                End;
  End;
end;

procedure TEditFocus.KeyPress(var Key: Char);
begin
  inherited;
  If Not fEntraCons(Key) Then
    Exit;

  If Not Principal Then
    Exit;

  case TipoPessoa of
    tpessRemetente: Begin
                      case TipoDocumento of
                        tdNotaCompra: pConsultaCadastroFornecedor(Key);
                        tdNotaVenda: pConsultaCadastroEmpresa(Key);
                        tdNotaDevolucaoVenda: pConsultaCadastroCliente(Key);
                        tdnotaDevolucaoCompra: pConsultaCadastroEmpresa(Key);
                      End;
                    End;
    tpessEmitente: Begin
                     case TipoDocumento of
                       tdNotaCompra: pConsultaCadastroFornecedor(Key);
                       tdNotaVenda: pConsultaCadastroFornecedor(Key);
                       tdNotaDevolucaoVenda: pConsultaCadastroFornecedor(Key);
                       tdnotaDevolucaoCompra: pConsultaCadastroFornecedor(Key);
                     End;
                   End;
    tpessDestinatario: Begin
                         case TipoDocumento of
                           tdNotaCompra: pConsultaCadastroEmpresa(Key);
                           tdNotaVenda: pConsultaCadastroCliente(Key);
                           tdNotaDevolucaoVenda: pConsultaCadastroEmpresa(Key);
                           tdnotaDevolucaoCompra: pConsultaCadastroFornecedor(Key);
                         End;
                       End;
    tpessTomador : pConsultaCadastroEmpresa(Key);
    tpessExpedidor: pConsultaCadastroCliente(Key);
    tpessRecebedor: pConsultaCadastroEmpresa(Key);
  End;
end;

procedure TEditFocus.pCarregaCamposTomador;
var recPessoa: TPessoaCTE;
    i: integer;
begin
  If Tomador = 4 Then
    exit;
  If Assigned(AgrupadorTomador) Then
  Begin
    recPessoa := fRetPessoa(Tomador, -1);
    For i := 0 To AgrupadorTomador.ControlCount -1 Do
    Begin
      If AgrupadorTomador.Controls[i] is TEditFocus Then
        pSetValueEdit(AgrupadorTomador.Controls[i], recPessoa);
    End;
  End;
end;

procedure TEditFocus.pCarregadados;
begin

  case TipoPessoa of
    tpessRemetente: Begin
                      case TipoDocumento of
                        tdNotaCompra: pCarregaDadosFornecedor;
                        tdNotaVenda: pCarregaDadosEmpresa;
                        tdNotaDevolucaoVenda: pCarregaDadosCliente;
                        tdNotaDevolucaoCompra: pCarregaDadosEmpresa;
                      End;
                    End;
    tpessEmitente: Begin
                     case TipoDocumento of
                       tdNotaCompra: pCarregaDadosFornecedor;
                       tdNotaVenda: pCarregaDadosFornecedor;
                       tdNotaDevolucaoVenda: pCarregaDadosFornecedor;
                       tdNotaDevolucaoCompra: pCarregaDadosFornecedor;
                     End;
                   End;
    tpessDestinatario: Begin
                         case TipoDocumento of
                           tdNotaCompra: pCarregaDadosEmpresa;
                           tdNotaVenda: pCarregaDadosCliente;
                           tdNotaDevolucaoVenda: pCarregaDadosEmpresa;
                           tdNotaDevolucaoCompra: pCarregaDadosFornecedor;
                         End;
                       End;
    tpessTomador : pCarregaDadosEmpresa;
    tpessExpedidor: pCarregaDadosCliente;
    tpessRecebedor: pCarregaDadosEmpresa;

  End;
end;

procedure TEditFocus.pCarregaDadosEmpresa;
var qryConsulta: TUniQuery;
begin
  If Assigned(FQryDados) Then
    Text := FQryDados.FieldByName('EMP_C_G_C_').AsString;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('    SELECT EMP_C_G_C_ AS CNPJ,');
    qryConsulta.SQL.Add('       EMP_NOMEMP AS NOME,');
    qryConsulta.SQL.Add('       EMP_I_E_S_ AS IE,');
    qryConsulta.SQL.Add('       CID_ESTADO AS ESTADO,');
    qryConsulta.SQL.Add('       EMP_ENDERE AS ENDERE,');
    qryConsulta.SQL.Add('       EMP_ENDNUM AS ENDNUM,');
    qryConsulta.SQL.Add('       EMP_BAIRRO AS BAIRRO,');
    qryConsulta.SQL.Add('       EMP_C_E_P_ AS CEP,');
    qryConsulta.SQL.Add('       CID_NOMCID AS NOMCID,');
    qryConsulta.SQL.Add('       CID_CODCOR AS CORREIO,');
    qryConsulta.SQL.Add('       CID_COIBGE AS IBGE');
    qryConsulta.SQL.Add('  FROM CADEMP');
    qryConsulta.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
    If Text <> '' Then
      qryConsulta.SQL.Add(' WHERE CADEMP.EMP_C_G_C_ = "'+Text+'"')
    Else
      qryConsulta.SQL.Add(' WHERE CADEMP.AUTOINCREM = "'+FQryDados.FieldByName('AUTOINCREM').AsString+'"');
    qryConsulta.Open;
    pPreencheDependentes(qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TEditFocus.pCarregaDadosCliente;
var qryConsulta: TUniQuery; strCodCli : String;
begin
  If Assigned(FQryDados) Then
  Begin
    Text := FQryDados.FieldByName('CLI_C_G_C_').AsString;
    strCodCli := FQryDados.FieldByName('CLI_CODCLI').AsString;
  End;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT CLI_C_G_C_ AS CNPJ,');
    qryConsulta.SQL.Add('       CLI_NOMCLI NOME,');
    qryConsulta.SQL.Add('       CLI_I_E_S_ IE,');
    qryConsulta.SQL.Add('       CID_ESTADO ESTADO,');
    qryConsulta.SQL.Add('       CLI_ENDERE ENDERE,');
    qryConsulta.SQL.Add('       CLI_ENDNUM ENDNUM,');
    qryConsulta.SQL.Add('       CLI_BAIRRO BAIRRO,');
    qryConsulta.SQL.Add('       CLI_C_E_P_ CEP,');
    qryConsulta.SQL.Add('       CID_NOMCID NOMCID,');
    qryConsulta.SQL.Add('       CID_CODCOR CORREIO,');
    qryConsulta.SQL.Add('       CID_COIBGE IBGE');
    qryConsulta.SQL.Add('  FROM CADCLI');
    qryConsulta.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID');
    If Text <> '' Then
    Begin
      qryConsulta.SQL.Add(' WHERE CADCLI.CLI_C_G_C_ = "'+Text+'"');
      If ((Text= '00000000000000') Or (Text = '00000000000')) And (Not fEmptyStr(strCodCli)) Then
        qryConsulta.SQL.Add(' And CADCLI.CLI_CODCLI = "'+strCodCli+'"');
    End
    Else
      qryConsulta.SQL.Add(' WHERE CADCLI.AUTOINCREM = "'+FQryDados.FieldByName('AUTOINCREM').AsString+'"');
    qryConsulta.Open;
    pPreencheDependentes(qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;


procedure TEditFocus.pCarregaDadosFornecedor;
var qryConsulta: TUniQuery; strCodFor : String;
begin
  If Assigned(FQryDados) Then
  Begin
    Text := FQryDados.FieldByName('FOR_C_G_C_').AsString;
    strCodFor := FQryDados.FieldByName('FOR_CODFOR').AsString;
  End;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT FOR_C_G_C_ AS CNPJ, ');
    qryConsulta.SQL.Add('       FOR_NOMFOR NOME, ');
    qryConsulta.SQL.Add('       FOR_I_E_S_ IE, ');
    qryConsulta.SQL.Add('       CID_ESTADO ESTADO, ');
    qryConsulta.SQL.Add('       FOR_ENDERE ENDERE, ');
    qryConsulta.SQL.Add('       FOR_ENDNUM ENDNUM, ');
    qryConsulta.SQL.Add('       FOR_BAIRRO BAIRRO, ');
    qryConsulta.SQL.Add('       FOR_C_E_P_ CEP, ');
    qryConsulta.SQL.Add('       CID_NOMCID NOMCID,');
    qryConsulta.SQL.Add('       CID_CODCOR CORREIO, ');
    qryConsulta.SQL.Add('       CID_COIBGE IBGE ');
    qryConsulta.SQL.Add('  FROM CADFOR ');
    qryConsulta.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = FOR_CODCID ');
    If Text <> '' Then
    Begin
      qryConsulta.SQL.Add(' WHERE CADFOR.FOR_C_G_C_ = "'+Text+'"');
      If ((Text= '00000000000000') Or (Text = '00000000000')) And (Not fEmptyStr(strCodFor)) Then
        qryConsulta.SQL.Add(' And CADFOR.FOR_CODFOR = "'+strCodFor+'"');
    End
    Else
      qryConsulta.SQL.Add(' WHERE CADFOR.AUTOINCREM = "'+FQryDados.FieldByName('AUTOINCREM').AsString+'"');
    qryConsulta.Open;
    pPreencheDependentes(qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TEditFocus.pConsultaCadastroCliente(var Key: Char);
var arrSel: TConsultasArray;
begin
  FQryDados := fCriaQuery;
  Try
    If fPesqCliente(conCliSimples,
                    FormPai,
                    nil,
                    nil,
                    FQryDados,
                    Key,
                    arrSel) Then
    begin
      pCarregadados
    End;
  Finally
    FreeAndNil(FQryDados);
  End;
end;

procedure TEditFocus.pConsultaCadastroEmpresa(var Key: Char);
var arrSel: TConsultasArray;
begin
  FQryDados := fCriaQuery;
  Try
    If fPesqEmpresa(conEmpSimples,
                    FormPai,
                    nil,
                    nil,
                    FQryDados,
                    Key,
                    arrSel) Then
    begin
      pCarregadados
    End;
  Finally
    FreeAndNil(FQryDados);
  End;

end;

procedure TEditFocus.pConsultaCadastroFornecedor(var Key: Char);
var arrSel: TConsultasArray;
begin
  FQryDados := fCriaQuery;
  Try
    If fPesqFornecedor(conForSimples,
                       FormPai,
                       nil,
                       nil,
                       FQryDados,
                       Key,
                       arrSel) Then
    begin
      pCarregadados
    End;
  Finally
    FreeAndNil(FQryDados);
  End;
end;

procedure TEditFocus.pLimpaGrupo;
  var i: integer;
begin
  For i := 0 To Agrupador.ControlCount -1 Do
  Begin
    If Agrupador.Controls[i] is TEditFocus Then
      TEditFocus(Agrupador.Controls[i]).Text := '';
  End;
end;

procedure TEditFocus.pLimpaTodosOsCampos;
var i: integer;
begin
  For i := 0 To Agrupador.ControlCount -1 Do
  Begin
    If Agrupador.Controls[i] is TEditFocus Then
      TEditFocus(Agrupador.Controls[i]).Text := '';
  End;
end;

procedure TEditFocus.pPreencheDependentes(qry: TUniQuery);
var i: integer;
begin
  For i := 0 To Agrupador.ControlCount -1 Do
  Begin
    If Agrupador.Controls[i] is TEditFocus Then
    Begin
      TEditFocus(Agrupador.Controls[i]).strOldValue := TEditFocus(Agrupador.Controls[i]).Text;
      TEditFocus(Agrupador.Controls[i]).Text := fGetConteudo(TEditFocus(Agrupador.Controls[i]).TipoCampoIdentificado, qry);
      TEditFocus(Agrupador.Controls[i]).strNewValue := TEditFocus(Agrupador.Controls[i]).Text;
    End;
  End;
end;

procedure TEditFocus.pPreenchido;
begin
  If Text = '' Then
  Begin
    case TipoPessoa Of
      tpessRemetente: raise exception.Create('O Remetente deve ser preenchido!');
      tpessEmitente: raise exception.Create('O Emitente deve ser preenchido!');
      tpessDestinatario: raise exception.Create('O Destinatário deve ser preenchido!');
      tpessTomador: raise exception.Create('O Tomador deve ser preenchido!');
    End;
  End;
end;

procedure TEditFocus.pSetPessoa(recPessoa: TPessoaCTE);
  var i: integer;
begin
  For i := 0 To Agrupador.ControlCount -1 Do
  Begin
    If Agrupador.Controls[i] is TEditFocus Then
      pSetValueEdit(Agrupador.Controls[i], recPessoa);
  End;
end;

procedure TEditFocus.pSetValueEdit(WinControl: TControl;
  recPessoa: TPessoaCTE);
begin
  case TEditFocus(WinControl).TipoCampoIdentificado of
    tciCNPJ           : TEditFocus(WinControl).Text := recPessoa.strCNPJ;
    tcirazaoSocial    : TEditFocus(WinControl).Text := recPessoa.strRAZAO_SOCIAL;
    tciIE             : TEditFocus(WinControl).Text := recPessoa.strINSCRICAO_ESTADUAL;
    tciUF             : TEditFocus(WinControl).Text := recPessoa.strUF;
    tciLogradouro     : TEditFocus(WinControl).Text := recPessoa.xLgr;
    tciNumero         : TEditFocus(WinControl).Text := recPessoa.xNro;
    tciBairro         : TEditFocus(WinControl).Text := recPessoa.xBairro;
    tciCEP            : TEditFocus(WinControl).Text := recPessoa.strCEP;
    tciMunicipio      : TEditFocus(WinControl).Text := recPessoa.xMun;
    tciCodigoMunicipio: TEditFocus(WinControl).Text := recPessoa.cMun;
    tciCodigoIBGE     : TEditFocus(WinControl).Text := recPessoa.strCODIBGE;
  End;
end;

end.
