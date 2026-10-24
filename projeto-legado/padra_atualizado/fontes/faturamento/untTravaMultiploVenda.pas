unit untTravaMultiploVenda;

interface

uses
  SysUtils,
  StrUtils,
  Classes,
  Generics.Collections,
  untLiberacao,
  untFuncoesSimples;

const strDivisao = '|------------------------------------------------------------------------------------------|';
const strCabeca  = '| Código | Descrição                                         | Qtd. Digit | Múltiplo Venda |';
const strTitulo  = 'Itens da venda com quantidade digitada diferente do múltiplo de venda.';

type
  TTipoTrava = (ttTodos, ttAvisa, ttTrava, ttLibera);

type
  TItemLiberadoTravaMultiploVenda = class
    private
      FstrCodIte: String;
      FfltQtdIte: Double;
      FfltMltVen: Double;
    public
      constructor Create();

      procedure pClear();

      procedure pSetCodIte(strCodIte: String);
      procedure pSetQtdIte(fltQtdIte: Double);
      procedure pSetMltVen(fltMltVen: Double);

      function fGetCodIte():String;
      function fGetQtdIte():Double;
      function fGetMltVen():Double;

      function fEhIgual(strCodIte: String;
                        fltQtdIte: Double;
                        fltMltVen: Double):Boolean;

  end;

type
  TListaItemLiberadoTravaMultiploVenda = class(TObjectList<TItemLiberadoTravaMultiploVenda>)
    private
      function fAdd():TItemLiberadoTravaMultiploVenda; overload;
    public
      function fAdd(Const strCodIte: String;
                    Const fltQtdDig: Double;
                    Const fltMltVen: Double):TItemLiberadoTravaMultiploVenda; overload;

      function fLocate(strCodIte: String;
                       fltQtdIte: Double;
                       fltMltVen: Double):Integer;

      function fExiste(strCodIte: String;
                       fltQtdIte: Double;
                       fltMltVen: Double):Boolean;
  end;

type
  TItemTravaMultiploVenda = class
    private
      FstrCodIte: String;
      FstrDesIte: String;
      FfltMltVen: Double;
      FfltQtdDig: Double;
      FstrTipTrv: String;
    public
      constructor Create();

      procedure pClear();

      procedure pSetCodIte(Const strCodIte: String);
      procedure pSetDesIte(Const strDesIte: String);
      procedure pSetMltVen(Const fltMltVen: Double);
      procedure pSetQtdDig(Const fltQtdDig: Double);
      procedure pSetTipTrv(Const strTipTrv: String);

      function fGetCodIte():String;
      function fGetDesIte():String;
      function fGetMltVen():Double;
      function fGetQtdDig():Double;
      function fGetTipTrv():String;

      function fGetMensagem(objLiberacao: TLiberacao = nil):String;

      function fEhItem(aTipoTrava: TTipoTrava):Boolean;
      function fEhIgual(Const strCodIte: String;
                        Const strDesIte: String;
                        Const fltMltVen: Double;
                        Const fltQtdDig: Double;
                        Const strTipTrv: String):Boolean;
  end;


type
  TListaItemTravaMultiploVenda = class(TObjectList<TItemTravaMultiploVenda>)
    private
      function fAdd():TItemTravaMultiploVenda; overload;
      function fGetCabecalhoMensagem(objLiberacao: TLiberacao = nil):String;
    public
      function fAdd(Const strCodIte: String;
                    Const strDesIte: String;
                    Const fltMltVen: Double;
                    Const fltQtdDig: Double;
                    Const strTipTrv: String):TItemTravaMultiploVenda; overload;

      function fLocate(Const strCodIte: String;
                       Const strDesIte: String;
                       Const fltMltVen: Double;
                       Const fltQtdDig: Double;
                       Const strTipTrv: String):Integer;

      function fExisteItens(aTipoTrava: TTipoTrava):Boolean;
      function fGetMensagem(aTipoTrava: TTipoTrava; objLiberacao: TLiberacao = nil):String;
  end;

implementation

{ TItemTravaMultiploVenda }

constructor TItemTravaMultiploVenda.Create;
begin
  Self.pClear;
end;

function TItemTravaMultiploVenda.fGetCodIte: String;
begin
  Result := FstrCodIte;
end;

function TItemTravaMultiploVenda.fGetDesIte: String;
begin
  Result := FstrDesIte;
end;

function TItemTravaMultiploVenda.fGetMensagem(objLiberacao: TLiberacao = nil): String;
begin
  Result := '|' + fPreencheEspaco(FstrCodIte, 7) + ' |' +
                  fPreencheEspaco(LeftStr(FstrDesIte,50), 50) + ' |' +
                  fPreencheEspaco(FloatToStrF(FfltQtdDig, ffNumber, 12, 3), 11, False) + ' |' +
                  fPreencheEspaco(FloatToStrF(FfltMltVen, ffNumber, 12, 3), 15, False) + ' |';

  If (Assigned(objLiberacao)) Then
    objLiberacao.objMsgLibera.pAddTexto(Result);
end;

function TItemTravaMultiploVenda.fGetMltVen: Double;
begin
  Result := FfltMltVen;
end;

function TItemTravaMultiploVenda.fGetQtdDig: Double;
begin
  Result := FfltQtdDig;
end;

function TItemTravaMultiploVenda.fGetTipTrv: String;
begin
  Result := FstrTipTrv;
end;

function TItemTravaMultiploVenda.fEhItem(aTipoTrava: TTipoTrava): Boolean;
begin
  Result := False;
  Case aTipoTrava Of
    ttTodos:  Result := True;
    ttAvisa:  Result := (FstrTipTrv = '3');
    ttTrava:  Result := (FstrTipTrv = '1');
    ttLibera: Result := (FstrTipTrv = '4');
  End;
end;

function TItemTravaMultiploVenda.fEhIgual(Const strCodIte: String;
                                          Const strDesIte: String;
                                          Const fltMltVen: Double;
                                          Const fltQtdDig: Double;
                                          Const strTipTrv: String):Boolean;
begin
  Result := False;

  If (strCodIte <> Self.FstrCodIte) Then
    Exit;

  If (strDesIte <> Self.FstrDesIte) Then
    Exit;

  If (fltMltVen <> Self.FfltMltVen) Then
    Exit;

  If (fltQtdDig <> Self.FfltQtdDig) Then
    Exit;

  If (strTipTrv <> Self.FstrTipTrv) Then
    Exit;

  Result := True;
end;

procedure TItemTravaMultiploVenda.pClear;
begin
  FstrCodIte := '';
  FstrDesIte := '';
  FfltMltVen := 0;
  FfltQtdDig := 0;
  FstrTipTrv := '';
end;

procedure TItemTravaMultiploVenda.pSetCodIte(const strCodIte: String);
begin
  FstrCodIte := strCodIte;
end;

procedure TItemTravaMultiploVenda.pSetDesIte(const strDesIte: String);
begin
  FstrDesIte := strDesIte;
end;

procedure TItemTravaMultiploVenda.pSetMltVen(const fltMltVen: Double);
begin
  FfltMltVen := fltMltVen;
end;

procedure TItemTravaMultiploVenda.pSetQtdDig(const fltQtdDig: Double);
begin
  FfltQtdDig := fltQtdDig;
end;

procedure TItemTravaMultiploVenda.pSetTipTrv(const strTipTrv: String);
begin
  FstrTipTrv := strTipTrv;
end;

{ TListaItemTravaMultiploVenda }

function TListaItemTravaMultiploVenda.fAdd(): TItemTravaMultiploVenda;
begin
  Result := TItemTravaMultiploVenda.Create();
  Self.Add(Result);
end;

function TListaItemTravaMultiploVenda.fAdd(Const strCodIte: String;
                                           Const strDesIte: String;
                                           Const fltMltVen: Double;
                                           Const fltQtdDig: Double;
                                           Const strTipTrv: String):TItemTravaMultiploVenda;
var
  intIndex: Integer;
begin
  intIndex := Self.fLocate(strCodIte, strDesIte, fltMltVen, fltQtdDig, strTipTrv);

  If (intIndex > -1) Then
    Exit(Self[intIndex]);

  Result := Self.fAdd();

  Result.pSetCodIte(strCodIte);
  Result.pSetDesIte(strDesIte);
  Result.pSetMltVen(fltMltVen);
  Result.pSetQtdDig(fltQtdDig);
  Result.pSetTipTrv(strTipTrv);
end;

function TListaItemTravaMultiploVenda.fExisteItens(aTipoTrava: TTipoTrava): Boolean;
var
  intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    If Self[intIndex].fEhItem(aTipoTrava) Then
      Exit(True);
  End;
end;


function TListaItemTravaMultiploVenda.fGetCabecalhoMensagem(objLiberacao: TLiberacao = nil): String;
var
  stlTexto: TStringList;
  intIndex: Integer;
begin
  stlTexto := TStringList.Create;
  Try
    stlTexto.Add(strTitulo);
    stlTexto.Add(strDivisao);
    stlTexto.Add(strCabeca);
    stlTexto.Add(strDivisao);

    Result := stlTexto.Text;

    If Assigned(objLiberacao) Then
    Begin
      For intIndex := 0 To PRed(stlTexto.Count) Do
        objLiberacao.objMsgLibera.pAddTexto(stlTexto[intIndex]);
    End;
  Finally
    FreeAndNil(stlTexto);
  End;
end;

function TListaItemTravaMultiploVenda.fGetMensagem(aTipoTrava: TTipoTrava; objLiberacao: TLiberacao = nil): String;
var
  stlTexto: TStringList;
  intIndex: Integer;
begin
  Result := '';

  If (Not Self.fExisteItens(aTipoTrava)) Then
    Exit;

  stlTexto := TStringList.Create;

  Try
    stlTexto.Text := Self.fGetCabecalhoMensagem(objLiberacao);

    For intIndex := 0 To PRed(Self.Count) Do
    Begin
      If Self[intIndex].fEhItem(aTipoTrava) Then
        stlTexto.Add(Self[intIndex].fGetMensagem(objLiberacao));
    End;

    stlTexto.Add(strDivisao);

    If Assigned(objLiberacao) Then
      objLiberacao.objMsgLibera.pAddTexto(strDivisao);

    Result := stlTexto.Text;
  Finally
    FreeAndNil(stlTexto);
  End;
end;



function TListaItemTravaMultiploVenda.fLocate(const strCodIte: String;
                                              const strDesIte: String;
                                              const fltMltVen: Double;
                                              const fltQtdDig: Double;
                                              const strTipTrv: String): Integer;
var
  intIndex: Integer;
begin
  Result := -1;
  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    If Self[intIndex].fEhIgual(strCodIte, strDesIte, fltMltVen, fltQtdDig, strTipTrv) Then
      Exit(intIndex);
  End;
end;

{ TItemLiberadoTravaMultiploVenda }

constructor TItemLiberadoTravaMultiploVenda.Create;
begin
  Self.pClear();
end;

function TItemLiberadoTravaMultiploVenda.fEhIgual(strCodIte: String; fltQtdIte, fltMltVen: Double): Boolean;
begin
  Result := False;

  If (strCodIte <> Self.FstrCodIte) Then
    Exit;

  If (fltQtdIte <> Self.FfltQtdIte) Then
    Exit;

  If (fltMltVen <> Self.FfltMltVen) Then
    Exit;

  Result := True;
end;

function TItemLiberadoTravaMultiploVenda.fGetCodIte: String;
begin
  Result := FstrCodIte;
end;

function TItemLiberadoTravaMultiploVenda.fGetMltVen: Double;
begin
  Result := FfltMltVen;
end;

function TItemLiberadoTravaMultiploVenda.fGetQtdIte: Double;
begin
  Result := FfltQtdIte;
end;

procedure TItemLiberadoTravaMultiploVenda.pClear;
begin
  FstrCodIte := '';
  FfltQtdIte := 0;
  FfltMltVen := 0;
end;

procedure TItemLiberadoTravaMultiploVenda.pSetCodIte(strCodIte: String);
begin
  FstrCodIte := strCodIte;
end;

procedure TItemLiberadoTravaMultiploVenda.pSetMltVen(fltMltVen: Double);
begin
  FfltMltVen := fltMltVen;
end;

procedure TItemLiberadoTravaMultiploVenda.pSetQtdIte(fltQtdIte: Double);
begin
  FfltQtdIte := fltQtdIte;
end;

{ TListaItemLiberadoTravaMultiploVenda }

function TListaItemLiberadoTravaMultiploVenda.fAdd: TItemLiberadoTravaMultiploVenda;
begin
  Result := TItemLiberadoTravaMultiploVenda.Create;
  Self.Add(Result);
end;

function TListaItemLiberadoTravaMultiploVenda.fAdd(const strCodIte: String;
                                                   const fltQtdDig: Double;
                                                   const fltMltVen: Double): TItemLiberadoTravaMultiploVenda;
var
  intIndex: Integer;
begin
  intIndex := Self.fLocate(strCodIte, fltQtdDig, fltMltVen);

  If (intIndex > -1) Then
    Exit(Self[intIndex]);

  Result := Self.fAdd();

  Result.pSetCodIte(strCodIte);
  Result.pSetQtdIte(fltQtdDig);
  Result.pSetMltVen(fltMltVen);
end;

function TListaItemLiberadoTravaMultiploVenda.fExiste(strCodIte: String;
                                                      fltQtdIte: Double;
                                                      fltMltVen: Double): Boolean;
begin
  Result := (Self.fLocate(strCodIte, fltQtdIte, fltMltVen) > -1);
end;

function TListaItemLiberadoTravaMultiploVenda.fLocate(strCodIte: String;
                                                      fltQtdIte: Double;
                                                      fltMltVen: Double): Integer;
var
  intIndex: Integer;
begin
  Result := -1;
  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    If Self[intIndex].fEhIgual(strCodIte, fltQtdIte, fltMltVen) Then
      Exit(intIndex);
  End;
end;

end.
