unit PontoEntrada.Script.Interfaces;

interface

uses
  fs_iinterpreter, System.Generics.Collections;
//  System.SysUtils, System.Classes, System.Rtti,
//  Vcl.stdCtrls, fs_ipascal,  Forms, Variants;

type
  IfsObjectInfo = interface
    ['{DA38B3E2-0BF4-47E6-80CA-BCB7C3B3995F}']
    function Category: String;
    function Name: String;
    function ObjectRef: TObject; overload;
    function ObjectRef(AValue: TObject): IfsObjectInfo; overload;
  end;

  IfsVariableInfo = interface
    ['{3ABB868C-FDA4-4C17-89D0-BB3A92D09EFF}']
    function Category: String;
    function Name: String;
    function Typ: String;
    function Value: Variant;
  end;

  IfsClassInfo = interface
    ['{DCE86303-7F16-4ACB-9F17-F219FA003687}']
    function Category: String;
    function ClassRef: TClass;
    function ClassName: String;
    function Properties: TArray<String>;
    function Methods: TArray<String>;
    function Execute(Instance: TObject; const MethodName: String;
      Caller: TfsMethodHelper): Variant;
  end;

  IfsPascalScriptParams = interface
    ['{6404AF04-B532-45B6-BF2D-6A62AF9E2BD8}']
    function Description(): String; overload;
    function Description(AValue: String): IfsPascalScriptParams; overload;
    function ScriptText(): String; overload;
    function ScriptText(AValue: String): IfsPascalScriptParams; overload;
    function WatchList(): String; overload;
    function WatchList(AValue: String): IfsPascalScriptParams; overload;
    function AddClass(AClassInfo: IfsClassInfo): IfsPascalScriptParams;
    function AddObject(AObject: IfsObjectInfo): IfsPascalScriptParams;
    function AddVariable(AVariable: IfsVariableInfo): IfsPascalScriptParams;
    function Classes: TDictionary<String, IfsClassInfo>;
    function Objects: TDictionary<String, IfsObjectInfo>;
    function Variables: TDictionary<String, IfsVariableInfo>;
  end;

implementation

end.
