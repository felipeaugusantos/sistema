unit untFuncoesGenerica;

interface

Uses SysUtils, iniFiles, Forms;

Type
  TPais = (opcBrasil, opcParaguai);

Type
  TCgcCpf = (C_G_C_, C_P_F_);

Type
  TCaptionCgcCpf = (capC_G_C_, capC_P_F_, capGERAL_);

function fFormataFone(strFone: String): String;
function fRetMascaraFone(opcPais: TPais): String;
function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf): String;
function fRetCaptionRG(opcPais: TPais): String;
function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
function fTiraCaracEspeciaisParenteses(strTexto: String): String;
function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;

function fSetaPais: TPais;
function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
function fRetSiglaPais(opcPais: TPais): String;
function fRetSiglaPaisAtual: String;
function fPodeValidarCgcCpf(FPais: TPais): Boolean;
function fMostraTipoCgcCpf(FPais: TPais): Boolean;

procedure pGravaCfgPais(strSigPai: String);

implementation

function fFormataFone(strFone: String): String;
Begin
  strFone := Trim(fTiraCaracEspeciaisParenteses(strFone));
  If Length(strFone) > 6 Then
  Begin
    Insert('-',strFone,Length(strFone)-3);

    If Length(strFone) > 8 Then
    Begin
      Insert(')',strFone,3);
      strFone := '('+ strFone;
    End;
  End;
  Result := strFone;
End;

function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  Var
    iniArqIni: TIniFile;
Begin
  iniArqIni := TIniFile.Create(strPath + '\opcoes.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;

End;

function fSetaPais: TPais;
Var
  strPais: String;
Begin
  strPais := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));
 
  If SameText(strPais, 'PAR') Then
    Result := opcParaguai
  Else
    Result := opcBrasil;

End;

function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
Begin
  If strCgcCpf = '1' Then
    Result := C_G_C_
  Else
    Result := C_P_F_;
End;

function fRetMascaraFone(opcPais: TPais): String;
Begin
  case opcPais Of
    opcBrasil  : Result := '!\(99\)9999-9999;0;_';
    opcParaguai: Result := '' ;
  end;
End;

function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf): String;
Begin
  Result := '';
  
  case opcPais Of
    opcBrasil: Begin
                 Case opcCgcCpf Of
                   C_G_C_: Result := '>aa\.aaa\.aaa/aaaa-99;0;';
                   C_P_F_: Result := '999.999.999-99;0;';
                 End;
               End;

    opcParaguai: Result := '';
  end;

End;

function fRetCaptionRG(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'R.G.:';
    opcParaguai: Result := 'CI:';
  end;
End;

function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
Begin
  Case opcPais Of
    opcBrasil  : Case opcCgcCpf Of
                   capC_G_C_: Result := 'CNPJ:';
                   capC_P_F_: Result := 'CPF:';
                   capGeral_: Result := '1-CNPJ/2-CPF:';
                 End;

    opcParaguai: Result := 'RUC:';
  end;
End;

procedure pGravaCfgPais(strSigPai: String);
Begin
  fArqIniGeral(1, 'PAIS', 'SIGLA', strSigPai, Pchar(ExtractFilePath(Application.ExeName)));
End;

function fRetSiglaPais(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'BRA';
    opcParaguai: Result := 'PAR';
  End;
End;

function fRetSiglaPaisAtual: String;
Begin
  Result := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));
End;

function fPodeValidarCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fMostraTipoCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

end.
