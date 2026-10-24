unit untCadBan;

Interface

uses Classes, DB, untFuncoesSimples, Uni;

Type TCadBandeira = Class (TComponent)
  Private
    FCodBan: String;
    FNomBan: String;
    FAutInc: String;
    FCodEmp: String;

    procedure setCodBan(const Value: String);
    procedure setNomBan(const Value: String);

  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodBan: String Read FCodBan   Write setCodBan;
    Property strNomBan: String Read FNomBan   Write setNomBan;

    Constructor Create(Owner: TComponent); Reintroduce;

  end;

Const
  arrCampos   : Array[0..3] Of String = ('BAN_CODBAN', 'BAN_NOMBAN', 'BAN_CODEMP', 'AUTOINCREM');

  arrDescricao: Array[0..3] Of String = ('Código', 'Nome', 'Código da Empresa', 'AUTOINCREM');

  arrTipo    : Array[0..3] Of TFieldType = (ftString, ftString, ftString, ftString);
  arrTamanhos: Array[0..3] Of Integer    = (3,40,3,20);
  arrVisible : Array[0..3] Of Boolean    = (True, True, False, False);
  arrFormat  : Array[0..3] Of String     = ('', '', '', '');

implementation

uses SysUtils;

{ TCadPor }

procedure TCadBandeira.setNomBan(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FNomBan := Value
  Else
    Raise Exception.Create('A descrição da Bandeira deve ser preenchida!');

end;

constructor TCadBandeira.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin

  Try
    SetLength(arrDefCam,4);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];
      arrDefCam[intContador].intTamCam := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADBAN WHERE FALSE');
    qryTabela.Open;

    FCodBan := '';
    FNomBan := '';
    FCodEmp := '';
    FAutInc := '';

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadBandeira!' + #13 + E.Message);

  End;

end;

procedure TCadBandeira.setCodBan(const Value: String);
begin

  If fEmptyStr (Value) Then
    Raise Exception.Create('O Código da Bandeira deve ser preenchido!')
  Else
    FCodBan := Value;

end;

end.

